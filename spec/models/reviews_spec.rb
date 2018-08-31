# frozen_string_literal: true

require "rails_helper"

RSpec.describe Review, type: :model do
  subject { build :review }

  it { should validate_presence_of(:rental) }
  it { should validate_presence_of(:review) }
  it { should validate_presence_of(:review_text) }

  it { should belong_to(:rental) }

  it { should have_one(:listing) }
  it { should have_one(:reviewer) }
end
