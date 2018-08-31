# frozen_string_literal: true

FactoryBot.define do
  sequence :username do |n|
    "customer-#{n}"
  end

  factory :user, aliases: %i[lessor lessee] do
    username { generate :username }
    password { "password" }

    trait :with_listing do
      transient do
        listings_count { 5 }
      end

      after(:create) do |user, evaluator|
        create_list(:listing, evaluator.listings_count, lessor: user)
      end
    end
  end
end
