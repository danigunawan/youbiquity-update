# frozen_string_literal: true

FactoryBot.define do
  sequence :username do |n|
    "customer-#{n}"
  end

  factory :user, aliases: %i[lessor lessee] do
    username { generate :username }
    password { "password" }

    trait :with_listings do
      transient do
        listings_count { 5 }
      end

      after(:create) do |user, evaluator|
        create_list(:listing, evaluator.listings_count, lessor: user)
      end
    end

    trait :with_listings_that_have_rented_out do
      transient do
        listings_count { 5 }
      end

      after(:create) do |user, evaluator|
        create_list(:listing, evaluator.listings_count, :with_rent_out, lessor: user)
      end
    end

    trait :with_received_rental_reviews do
      transient do
        listings_count { 5 }
      end

      after(:create) do |user, evaluator|
        create_list(:listing, evaluator.listings_count, :with_rent_out_reviews, lessor: user)
      end
    end

    trait :with_my_rental do
      transient do
        listings_count { 5 }
      end

      after(:create) do |user, evaluator|
        create_list(:rental, evaluator.listings_count, lessee: user)
      end
    end
  end
end
