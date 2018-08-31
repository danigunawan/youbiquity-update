# frozen_string_literal: true

require "rails_helper"

RSpec.describe Listing, type: :model do
  subject { build :listing }

  it { should validate_presence_of(:lessor) }
  it { should validate_presence_of(:listing_title) }
  it { should validate_presence_of(:detail_desc) }
  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:lat) }
  it { should validate_presence_of(:lng) }
  it { should validate_presence_of(:day_rate) }
  it { should validate_presence_of(:replacement_value) }
  it { should validate_presence_of(:serial) }
  it { should validate_presence_of(:brand) }
  it { should validate_presence_of(:category) }
  it { should validate_inclusion_of(:active).in_array([true, false]) }

  it { should belong_to(:lessor) }
  it { should belong_to(:brand) }
  it { should belong_to(:category) }

  it { should have_many(:rentals) }
  it { should have_many(:photos) }
  it { should have_many(:reviews) }
end
