require "rails_helper"
require "controllers/shared_examples/login_behavior"

RSpec.describe Api::ReviewsController, type: :controller do
  let(:expected_rentals_return_keys) do
    [
      "average_rating", "five_stars", "four_stars", "id", "one_stars",
      "three_stars", "total_count", "two_stars", "username"
    ]
  end
  let(:return_content) { JSON.parse(response.body) }

  describe "GET my_reviews" do
    let(:current_user) { create :user, :with_received_rental_reviews }
    let(:action) { :my_reviews }
    let(:params) {}
    let(:expected_rental_return_keys) do
      [
        "average_rating", "five_stars", "four_stars", "id", "one_stars",
        "three_stars", "total_count", "two_stars", "username"
      ]
    end

    it_behaves_like "logged and not logged in"

    context "logged in" do
      before { get(action, session: { session_token: current_user.session_token }) }

      it "returns the correct data format" do
        expect(return_content.keys).to match_array(expected_rental_return_keys)
      end
    end
  end

  describe "POST create" do
    let(:current_user) { create :user, :with_my_rental }
    let(:action) { :create }
    let(:rental_id) { current_user.my_rentals.first }
    let(:params) do
      {
        review: {
          rental_id:    rental_id,
          review:       5,
          review_text:  "Review Text",
        },
      }
    end
    let(:expected_review_return_keys) do
      ["id", "rental_id", "review", "review_text", "created_at", "updated_at"]
    end

    it_behaves_like "logged and not logged in"

    context "logged in" do
      before { get(action, session: { session_token: current_user.session_token }, params: params) }

      context "posts valid data" do
        it "returns the correct data format" do
          expect(return_content.keys).to match_array(expected_review_return_keys)
        end
      end

      context "posts invalid rental_id" do
        let(:rental_id) { -1 }

        subject { return_content }

        it { should match_array(["You can only review your own rentals"]) }
      end
    end
  end
end
