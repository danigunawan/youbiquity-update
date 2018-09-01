require "rails_helper"
require "controllers/shared_examples/login_behavior"

RSpec.describe Api::RentalsController, type: :controller do
  let(:action) { :index }

  it_behaves_like "logged and not logged in"
end
