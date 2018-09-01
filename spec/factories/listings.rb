# frozen_string_literal: true

FactoryBot.define do
  factory :listing do
    lessor
    brand
    category

    listing_title { "Listing Title" }
    detail_desc { "Detailed Description" }
    location { "Location" }
    lat { 100 }
    lng { 100 }
    day_rate { 10 }
    replacement_value { 1000 }
    serial { "Serial Number" }
    active { true }
  end
end
