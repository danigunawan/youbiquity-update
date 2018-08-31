# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    rental

    review { rand(1..5) }
    review_text { "Review Text" }
  end
end
