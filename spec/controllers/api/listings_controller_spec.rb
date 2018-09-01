require "rails_helper"
require "controllers/shared_examples/login_behavior"

RSpec.describe Api::ListingsController, type: :controller do
  describe "GET index" do
    let(:current_user) { create :user, :with_listings_that_has_rental }
    let(:action) { :index }

    it_behaves_like "logged and not logged in"

    context "logged in" do
      before { get(action, session: { session_token: current_user.session_token }) }

      it "returns the correct data format" do
        return_content = JSON.parse(response.body)
        expect(return_content.keys).to eq(current_user.listings.pluck(:id).map(&:to_s))
        return_content.values.flatten.each do |rental_hash|
          expect(rental_hash).to have_key("id")
          expect(rental_hash).to have_key("start_date")
          expect(rental_hash).to have_key("end_date")
          expect(rental_hash).to have_key("total")
          expect(rental_hash).to have_key("lessee")
        end
      end
    end
  end
end
