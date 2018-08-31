# frozen_string_literal: true

class Brand < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :listings
end
