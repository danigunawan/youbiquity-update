# frozen_string_literal: true

FactoryBot.define do
  start = rand(1..5).days.from_now
  ending = start + rand(1..5).days

  factory :rental do
    listing
    lessee

    start_date { start }
    end_date { ending }
  end
end
