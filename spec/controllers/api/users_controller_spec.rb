require "rails_helper"
require "controllers/shared_examples/login_behavior"

RSpec.describe Api::UsersController, type: :controller do
  let(:return_content) { JSON.parse(response.body) }

  describe "POST create" do
    let(:action) { :create }
    let(:rental_id) { current_user.my_rentals.first }
    let(:username) { "username" }
    let(:password) { "password" }
    let(:params) do
      {
        user: {
          username: username,
          password: password,
        },
      }
    end

    before { get(action, params: params) }

    context "posts valid data" do
      it "returns the correct data format" do
        expect(return_content).to eq("status" => "ok")
      end

      it "creates the user with correct data" do
        expect(User.last.username).to eq(username)
        expect(User.last.valid_password?(password)).to eq(true)
      end
    end

    context "posts without username" do
      let(:username) {}

      it "should return the correct error response" do
        expect(return_content).to match_array(["Username can't be blank"])
      end

      it "returns 422" do
        expect(response).to have_http_status(422)
      end

      it "returns correct content_type" do
        expect(response.content_type).to eq("application/json")
      end
    end

    context "posts without password" do
      let(:password) {}

      it "should return the correct error response" do
        expect(return_content).to match_array(["Password is too short (minimum is 6 characters)"])
      end

      it "returns 422" do
        expect(response).to have_http_status(422)
      end

      it "returns correct content_type" do
        expect(response.content_type).to eq("application/json")
      end
    end
  end
end
