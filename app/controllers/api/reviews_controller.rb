# frozen_string_literal: true

module Api
  class ReviewsController < ApplicationController
    def create
      rental = Rental.where(id: params[:review][:rental_id]).try(:first)
      if rental.nil? || rental.lessee != current_user
        return render json: ["You can only review your own rentals"], status: 422
      end

      review = Review.new(review_params)
      if review.save
        render json: review, status: 200
      else
        render json: review.errors.full_messages, status: 422
      end
    end

    def my_reviews
      render json: current_user.calculated_reviews, status: 200
    end

    private

    def review_params
      params.require(:review).permit(:rental_id, :review, :review_text)
    end
  end
end
