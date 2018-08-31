# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  subject { build :brand }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should have_many(:listings) }
end
