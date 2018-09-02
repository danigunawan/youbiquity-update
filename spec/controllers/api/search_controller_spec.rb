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

      it "returns the correct data format" do
        expect(return_content.keys).to match_array(Listing.pluck(:id).map(&:to_s))
        return_content.values.flatten.each do |listing_hash|
          expect(listing_hash.keys).to match_array(expected_listing_return_keys)
        end
      end
    end
  end
end
