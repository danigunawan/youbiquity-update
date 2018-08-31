# frozen_string_literal: true

class Rental < ActiveRecord::Base
  validates :listing, :lessee, :start_date, :end_date, presence: true

  belongs_to :lessee, class_name: :User, foreign_key: :lessee_id
  belongs_to :listing

  has_one :review
  has_one :lessor, through: :listing

  validate :end_date_before_start_date?, :overlap?, :in_the_future?

  def total
    days = (end_date - start_date).to_i
    rate = listing.day_rate
    days * rate
  end

  def find_overlap
    Rental.
      where.not(id: id).
      where(listing: listing).
      where("? BETWEEN start_date AND end_date OR " \
            "? BETWEEN start_date AND end_date", start_date, end_date).
      exists?
  end

  def end_date_before_start_date?
    return unless start_date && end_date
    errors.add(:drop_off, "must be after pick up date") if start_date >= end_date
  end

  def overlap?
    return unless start_date && end_date
    errors.add(:dates, "of another rental overlap yours") if find_overlap
  end

  def in_the_future?
    return unless start_date && end_date
    errors.add(:dates, "must be in the future") if start_date.past? || end_date.past?
  end
end
