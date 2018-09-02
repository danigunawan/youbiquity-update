require "rails_helper"
require "controllers/shared_examples/login_behavior"

RSpec.describe Api::ListingsController, type: :controller do
  let(:expected_listing_return_keys) do
    [
      "id", "lessor", "brand", "category", "listing_title", "detail_desc",
      "location", "lat", "lng", "day_rate", "replacement_value", "serial",
      "rating_average", "review_count", "photos", "reviews", "rentals"
    ]
  end
  let(:expected_rental_return_keys_index) do
    ["end_date", "id", "lessee", "start_date", "total"]
  end
  let(:expected_rental_return_keys_show_post) do
    ["created_at", "end_date", "id", "lessee_id", "listing_id", "start_date", "updated_at"]
  end
  let(:return_content) { JSON.parse(response.body) }

  describe "GET index" do
    let(:current_user) { create :user, :with_listings_that_have_rented_out }
    let(:action) { :index }
    let(:params) {}

    it_behaves_like "logged and not logged in"

    context "logged in" do
      before { get(action, session: { session_token: current_user.session_token }) }

      it "returns the correct data format" do
        expect(return_content.keys).to match_array(current_user.listings.pluck(:id).map(&:to_s))
        return_content.values.flatten.each do |rental_hash|
          expect(rental_hash.keys).to match_array(expected_rental_return_keys_index)
        end
      end
    end
  end

  describe "GET show" do
    let(:current_user) { create :user, :with_listings_that_have_rented_out }
    let(:action) { :show }
    let(:params) { { id: current_user.listings.first.id } }

    it_behaves_like "logged and not logged in"

    context "logged in" do
      before { get(action, params: params, session: { session_token: current_user.session_token }) }

      it "returns the correct data format" do
        expect(return_content.keys).to match_array(expected_listing_return_keys)
        return_content["rentals"].each do |rental_hash|
          expect(rental_hash.keys).to match_array(expected_rental_return_keys_show_post)
        end
      end
    end
  end

  describe "POST create" do
    let(:current_user) { create :user }
    let(:brand) { create :brand, name: "Brand Name" }
    let(:category) { create :category, name: "Category Name" }
    let(:action) { :create }
    let(:params) do
      {
        listing: {
          listing_title:      "Listing Title",
          detail_desc:        "Detailed Description",
          location:           "Location",
          lat:                100,
          lng:                100,
          day_rate:           50,
          replacement_value:  1000,
          serial:             "Serial Number",
          brand:              brand.name,
          category:           category.name,
          image_urls:         ["https://robohash.org/1", "https://robohash.org/2"],
        },
      }
    end

    it_behaves_like "logged and not logged in"

    context "logged in" do
      before { get(action, params: params, session: { session_token: current_user.session_token }) }

      it "returns the correct data format" do
        expect(return_content.keys).to match_array(expected_listing_return_keys)
        return_content["rentals"].each do |rental_hash|
          expect(rental_hash.keys).to match_array(expected_rental_return_keys_show_post)
        end
      end
    end
  end
end
