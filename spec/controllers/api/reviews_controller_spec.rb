require "rails_helper"
require "controllers/shared_examples/login_behavior"

RSpec.describe Api::ReviewsController, type: :controller do
  let(:current_user) { create :user }
  let(:action) { :my_reviews }
  let(:params) {}

  it_behaves_like "logged and not logged in"
end
