# frozen_string_literal: true

FactoryBot.define do
  sequence :category_name do |n|
    "category_name-#{n}"
  end

  factory :category do
    name { generate :category_name }
  end
end
