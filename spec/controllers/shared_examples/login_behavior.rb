RSpec.shared_examples "logged and not logged in" do
  context "not logged in" do
    before { get(action, params: params) }

    it "returns 401 when not logged in" do
      expect(response).to have_http_status(401)
    end

    it "returns correct json error" do
      expect(response.content_type).to eq("application/json")
      expect(JSON.parse(response.body)).to eq("error" => "not logged in")
    end
  end

  context "logged in" do
    before { get(action, params: params, session: { session_token: current_user.session_token }) }

    it "returns 200 when logged in" do
      expect(response).to have_http_status(200)
    end

    it "returns correct content_type" do
      expect(response.content_type).to eq("application/json")
    end
  end
end
