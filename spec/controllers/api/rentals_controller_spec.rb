require "rails_helper"
require "controllers/shared_examples/login_behavior"

RSpec.describe Api::RentalsController, type: :controller do
  let(:expected_rentals_return_keys) { ["rentals"] }
  let(:return_content) { JSON.parse(response.body) }

  describe "GET index" do
    let(:current_user) { create :user, :with_listings_that_have_rented_out }
    let(:action) { :index }
    let(:params) {}
    let(:expected_rental_return_keys) do
      ["id", "lessor", "listing_id", "start_date", "end_date", "total", "rating", "review"]
    end

    it_behaves_like "logged and not logged in"

    context "logged in" do
      before { get(action, session: { session_token: current_user.session_token }) }

      it "returns the correct data format" do
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
    let(:listing_id) { listing.id }
    let(:start_date) { 30.days.from_now }
    let(:end_date) { 31.days.from_now }
    let(:params) do
      {
        rental: {
          listing_id: listing_id,
          start_date: start_date,
          end_date:   end_date,
        },
      }
    end
    let(:expected_rental_return_keys) do
      ["id", "start_date", "end_date", "total", "lessor"]
    end

    it_behaves_like "logged and not logged in"

    context "logged in" do
      before { get(action, params: params, session: { session_token: current_user.session_token }) }

      context "posts valid data" do
        it "returns the correct data format" do
          expect(return_content.keys).to match_array(expected_rental_return_keys)
        end
      end

      context "posts invalid listing_id" do
        let(:listing_id) { nil }

        subject { return_content }

        it { should match_array(["Listing can't be blank"]) }
      end

      context "posts invalid start_date" do
        let(:start_date) { nil }

        subject { return_content }

        it { should match_array(["Start date can't be blank"]) }
      end

      context "posts invalid end_date" do
        let(:end_date) { nil }

        subject { return_content }

        it { should match_array(["End date can't be blank"]) }
      end
    end
  end
end
