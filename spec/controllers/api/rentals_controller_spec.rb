require "rails_helper"
require "controllers/shared_examples/login_behavior"

RSpec.describe Api::RentalsController, type: :controller do
  let(:current_user) { create :user }
  let(:action) { :index }
  let(:params) {}

  it_behaves_like "logged and not logged in"
end
