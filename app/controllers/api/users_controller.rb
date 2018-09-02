# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    skip_before_action :require_login

    def create
      user = User.new(user_params)
      if user.save
        sign_in(user)
        render json: { status: "ok" }, status: 200
      else
        render json: user.errors.full_messages, status: 422
      end
    end

    private

    def user_params
      params.require(:user).permit(:password, :username)
    end
  end
end
