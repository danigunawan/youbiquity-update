require "rails_helper"
require "controllers/shared_examples/login_behavior"

RSpec.describe Api::RentalsController, type: :controller do
  let(:expected_rentals_return_keys) { ["rentals"] }

  describe "GET index" do
    let(:current_user) { create :user, :with_listings_that_has_rental }
    let(:action) { :index }
    let(:params) {}
    let(:expected_rental_return_keys) do
      ["id", "lessor", "listing_id", "start_date", "end_date", "total", "rating", "review"]
    end

    it_behaves_like "logged and not logged in"

    context "logged in" do
      before { get(action, session: { session_token: current_user.session_token }) }

      it "returns the correct data format" do
        return_content = JSON.parse(response.body)
        expect(return_content.keys).to match_array(expected_rentals_return_keys)
        return_content.values.flatten.each do |rental_hash|
          expect(rental_hash.keys).to match_array(expected_rental_return_keys)
        end
      end
    end
  end

  describe "POST create" do
    let(:current_user) { create :user }
    let(:listing) { create :listing }
    let(:action) { :create }
    let(:params) do
      {
        rental: {
          listing_id: listing.id,
          start_date: 30.days.from_now,
          end_date:   33.days.from_now,
        },
      }
    end
    let(:expected_rental_return_keys) do
      ["id", "start_date", "end_date", "total", "lessor"]
    end

    it_behaves_like "logged and not logged in"

    context "logged in" do
      before { get(action, params: params, session: { session_token: current_user.session_token }) }

      it "returns the correct data format" do
        return_content = JSON.parse(response.body)
        expect(return_content.keys).to match_array(expected_rental_return_keys)
      end
    end
  end
end
