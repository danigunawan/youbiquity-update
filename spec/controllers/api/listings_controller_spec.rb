require "rails_helper"
require "controllers/shared_examples/login_behavior"

RSpec.describe Api::ListingsController, type: :controller do
  describe "GET index" do
    let(:current_user) { create :user, :with_listings_that_has_rental }
    let(:action) { :index }
    let(:params) {}
    let(:expected_rental_return_keys) do
      ["id", "start_date", "end_date", "total", "lessee"]
    end

    it_behaves_like "logged and not logged in"

    context "logged in" do
      before { get(action, session: { session_token: current_user.session_token }) }

      it "returns the correct data format" do
        return_content = JSON.parse(response.body)
        expect(return_content.keys).to eq(current_user.listings.pluck(:id).map(&:to_s))
        return_content.values.flatten.each do |rental_hash|
          expect(rental_hash.keys).to match_array(expected_rental_return_keys)
        end
      end
    end
  end

  describe "GET show" do
    let(:current_user) { create :user, :with_listings_that_has_rental }
    let(:action) { :show }
    let(:params) { { id: current_user.listings.first.id } }
    let(:expected_listing_return_keys) do
      [
        "id", "lessor", "brand", "category", "listing_title", "detail_desc",
        "location", "lat", "lng", "day_rate", "replacement_value", "serial",
        "rating_average", "review_count", "photos", "reviews", "rentals"
      ]
    end
    let(:expected_rental_return_keys) do
      [
        "id", "listing_id", "lessee_id", "start_date", "end_date", "created_at",
        "updated_at"
      ]
    end

    it_behaves_like "logged and not logged in"

    context "logged in" do
      before { get(action, params: params, session: { session_token: current_user.session_token }) }

      it "returns the correct data format" do
        return_content = JSON.parse(response.body)
        expect(return_content.keys).to match_array(expected_listing_return_keys)
        return_content["rentals"].each do |rental_hash|
          expect(rental_hash.keys).to match_array(expected_rental_return_keys)
        end
      end
    end
  end
end
