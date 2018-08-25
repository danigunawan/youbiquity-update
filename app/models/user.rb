# frozen_string_literal: true

class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :username, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  attr_reader :password

  has_many :listings, class_name: :Listing, foreign_key: :lessor_id
  has_many :rentals, through: :listings
  has_many :reviews, foreign_key: :lessee_id

  after_initialize :ensure_session_token

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user&.valid_password?(password)
    user
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def valid_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def reset_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    save!
    session_token
  end

  def average_listing_rating
    avg = Listing.
      joins(:reviews).
      where(lessor_id: id).
      average("reviews.review")

    avg&.round(0).to_i
  end

  def total_ratings_received
    Listing.
      joins(:reviews).
      where(lessor_id: id).
      sum("reviews.review")
  end

  def review_count_by_rating(rating)
    Listing.
      joins(:reviews).
      where(lessor_id: id).
      where("reviews.review = ?", rating).
      sum("reviews.review")
  end

  def review_count_received
    Listing.
      joins(:reviews).
      where(lessor_id: id).
      count
  end

  private

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end
end
