# frozen_string_literal: true

class Listing < ActiveRecord::Base
  validates :lessor, :listing_title, :detail_desc,
            :location, :lat, :lng, :day_rate, :replacement_value, :serial,
            :brand, :category, presence: true

  validates :active, inclusion: { in: [true, false] }

  belongs_to :lessor, class_name: :User, foreign_key: :lessor_id
  belongs_to :brand
  belongs_to :category

  has_many :rentals
  has_many :photos
  has_many :reviews, through: :rentals

  def rating_average
    avg = Listing.
      joins(:reviews).
      where(id: id).
      average(:review)

    avg&.round(0).to_i
  end

  def review_count
    Listing.
      joins(:reviews).
      where(id: id).
      count
  end
end
