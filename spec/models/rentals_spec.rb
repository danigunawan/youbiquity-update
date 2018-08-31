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

  context "custom validations" do
    describe "#end_date_before_start_date?" do
      subject do
        build :rental, start_date: 2.days.from_now, end_date: 1.day.from_now
      end

      it { should_not be_valid }
    end

    describe "#overlap?" do
      subject do
        build :rental
      end

      context "in between rental" do
        before do
          create :rental,
            start_date: subject.start_date + 1.day,
            end_date: subject.start_date + 2.days,
            listing_id: subject.listing_id
        end

        it { should_not be_valid }
      end

      context "around rental" do
        before do
          create :rental,
            start_date: subject.start_date - 1.day,
            end_date: subject.start_date + 2.days,
            listing_id: subject.listing_id
        end

        it { should_not be_valid }
      end
    end

    describe "#in_the_future?" do
      subject do
        build :rental, start_date: 2.days.ago, end_date: 1.day.ago
      end

      it { should_not be_valid }
    end
  end
end
