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

  def calculated_reviews
    @calculated_reviews ||= ActiveRecord::Base.
      connection.
      execute(
        "SELECT
          users.id,
          users.username,
          COUNT(*) as total_count,
          ROUND(AVG(reviews.review), 2) as average_rating,
          SUM(CASE WHEN reviews.review = 1 THEN 1 ELSE 0 END) as one_stars,
          SUM(CASE WHEN reviews.review = 2 THEN 1 ELSE 0 END) as two_stars,
          SUM(CASE WHEN reviews.review = 3 THEN 1 ELSE 0 END) as three_stars,
          SUM(CASE WHEN reviews.review = 4 THEN 1 ELSE 0 END) as four_stars,
          SUM(CASE WHEN reviews.review = 5 THEN 1 ELSE 0 END) as five_stars
        FROM
          users
        JOIN listings ON users.id = listings.lessor_id
        JOIN rentals ON listings.id = rentals.listing_id
        JOIN reviews ON rentals.id = reviews.rental_id
        WHERE users.id = #{id}
        GROUP BY users.id, users.username
        LIMIT 1",
      ).first
  end

  private

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end
end
