require "rails_helper"
require "controllers/shared_examples/login_behavior"

RSpec.describe Api::SearchController, type: :controller do
  let(:expected_listing_return_keys) do
    [
      "id", "lessor", "brand", "category", "day_rate", "lat", "lng",
      "rating_average", "review_count", "photos"
    ]
  end
  let(:return_content) { JSON.parse(response.body) }

  describe "GET index" do
    let(:current_user) { create :user, :with_listings }
    let(:action) { :index }
    let(:brand) {}
    let(:category) {}
    let(:price) {}
    let(:rating) {}
    let(:bounds) {}
    let(:params) do
      {
        brand: brand,
        category: category,
        price: price,
        rating: rating,
        bounds: bounds,
      }
    end

    it_behaves_like "logged and not logged in"

    context "logged in" do
      before { get(action, params: params, session: { session_token: current_user.session_token }) }

      context "no filters" do
        it "returns the correct data format" do
          expect(return_content.keys).to match_array(Listing.pluck(:id).map(&:to_s))
          return_content.values.each do |listing_hash|
            expect(listing_hash.keys).to match_array(expected_listing_return_keys)
          end
        end
      end

      context "with brand filter" do
        let(:brand) { [current_user.listings.first.brand.name] }

        it "returns the correct brand data subset" do
          return_content.values.flatten.each do |listing_hash|
            expect(brand).to include(listing_hash["brand"])
          end
        end
      end

      context "with category" do
        let(:category) { [current_user.listings.first.category.name] }

        it "returns the correct category data subset" do
          return_content.values.flatten.each do |listing_hash|
            expect(category).to include(listing_hash["category"])
          end
        end
      end

      context "with day_rate filter" do
        let(:price) { 2 }

        it "returns the correct day_rate data subset" do
          create :listing, day_rate: 1

          return_content.values.flatten.each do |listing_hash|
            expect(listing_hash["day_rate"]).to be < price
          end
        end
      end
    end
  end
end
