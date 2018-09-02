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

    trait :with_rent_out do
      transient do
        rentals_count { 1 }
      end

      after(:create) do |listing, evaluator|
        create_list(:rental, evaluator.rentals_count, listing: listing)
      end
    end

    trait :with_rent_out_reviews do
      transient do
        rentals_count { 1 }
      end

      after(:create) do |listing, evaluator|
        create_list(:rental, evaluator.rentals_count, :with_review, listing: listing)
      end
    end
  end
end
