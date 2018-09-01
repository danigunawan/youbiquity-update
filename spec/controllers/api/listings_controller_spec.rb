require "rails_helper"

RSpec.describe Api::ListingsController, type: :controller do
  describe "GET index" do
    let(:current_user) { create :user, :with_listings_that_has_rental }

    context "not logged in" do
      before { get(:index) }

      it "returns 401 when not logged in" do
        expect(response).to have_http_status(401)
      end

      it "returns correct json error" do
        expect(response.content_type).to eq("application/json")
        expect(JSON.parse(response.body)).to eq("error" => "not logged in")
      end
    end

    context "logged in" do
      before { get(:index, session: { session_token: current_user.session_token }) }

      it "returns 200 when logged in" do
        expect(response).to have_http_status(200)
      end

      it "returns correct content_type" do
        expect(response.content_type).to eq("application/json")
      end

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
