# frozen_string_literal: true

class Category < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :listings
end
