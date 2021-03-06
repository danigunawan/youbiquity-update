# frozen_string_literal: true

FactoryBot.define do
  sequence :brand_name do |n|
    "category_name-#{n}"
  end

  factory :brand do
    name { generate :brand_name }
  end
end
