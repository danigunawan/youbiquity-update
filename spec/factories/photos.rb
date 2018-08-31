# frozen_string_literal: true

FactoryBot.define do
  sequence :image_url do |n|
    "https://robohash.org/#{n}"
  end

  factory :photo do
    listing

    image_url { generate :image_url }
  end
end
