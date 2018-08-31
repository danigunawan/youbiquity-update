# frozen_string_literal: true

require "rails_helper"

RSpec.describe Rental, type: :model do
  subject { build :rental }

  it { should validate_presence_of(:listing) }
  it { should validate_presence_of(:lessee) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }

  it { should belong_to(:lessee) }
  it { should belong_to(:listing) }

  it { should have_one(:review) }
  it { should have_one(:lessor) }
end
