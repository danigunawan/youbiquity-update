# frozen_string_literal: true

module Api
  class SessionsController < ApplicationController
    skip_before_action :require_login

    def create
      user = User.find_by_credentials(
        params[:user][:username],
        params[:user][:password],
      )

      if user
        sign_in(user)
        render json: user, status: 200
      else
        error = ["Invalid username or password"]
        render json: error, status: 401
      end
    end

    def destroy
      sign_out
      render json: {}, status: 200
    end
  end
end
