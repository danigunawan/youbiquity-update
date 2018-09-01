require "rails_helper"
require "controllers/shared_examples/login_behavior"

RSpec.describe Api::ReviewsController, type: :controller do
  let(:action) { :my_reviews }

  it_behaves_like "logged and not logged in"
end
