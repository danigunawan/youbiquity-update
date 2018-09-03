require "rails_helper"
require "controllers/shared_examples/login_behavior"

RSpec.describe Api::SessionsController, type: :controller do
  let!(:current_user) { create :user }
  let(:return_content) { JSON.parse(response.body) }

  describe "POST create" do
    let(:action) { :create }
    let(:username) { current_user.username }
    let(:password) { "password" }
    let(:params) { { user: { username: username, password: password } } }

    before { get(action, params: params) }

    context "posts correct credentials" do
      it "returns 200" do
        expect(response).to have_http_status(200)
      end

      it "sets the correct session token" do
        expect(session[:session_token]).to eq(current_user.reload.session_token)
      end

      it "returns the correct session token" do
        expect(return_content).to eq("session_token" => current_user.reload.session_token)
      end

      it "returns correct content_type" do
        expect(response.content_type).to eq("application/json")
      end

      it "returns the correct data format" do
        expect(return_content.keys).to match_array(["session_token"])
      end
    end

    context "posts incorrect username" do
      let(:username) { "incorrect username" }

      it "returns 401" do
        expect(response).to have_http_status(401)
      end

      it "does not set the session token" do
        expect(session[:session_token]).to eq(nil)
      end

      it "returns correct content_type" do
        expect(response.content_type).to eq("application/json")
      end

      it "returns the correct error response" do
        expect(return_content).to eq("error" => "Invalid username or password")
      end
    end

    context "posts incorrect password" do
      let(:password) { "incorrect username" }

      it "returns 401" do
        expect(response).to have_http_status(401)
      end

      it "does not set the session token" do
        expect(session[:session_token]).to eq(nil)
      end

      it "returns correct content_type" do
        expect(response.content_type).to eq("application/json")
      end

      it "returns the correct error response" do
        expect(return_content).to eq("error" => "Invalid username or password")
      end
    end
  end

  describe "DELETE destroy" do
    let(:action) { :destroy }

    before { get(action, session: { session_token: current_user.session_token }) }

    it "nullifies the session token" do
      expect(session[:session_token]).to eq(nil)
    end

    it "resets the user's session token" do
      expect(current_user.session_token).not_to eq(current_user.reload.session_token)
    end
  end
end
