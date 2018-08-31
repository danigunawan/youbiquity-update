# frozen_string_literal: true

module Api
  class ReviewsController < ApplicationController
    def create
      if Rental.find(params[:review][:rental_id]).lessee != current_user
        return render json: ["You can only review your own rentals"],
                      status: 422
      end

      @review = Review.new(review_params)
      if @review.save
        render json: @review, status: 200
      else
        render json: @review.errors.full_messages, status: 422
      end
    end

    def my_reviews
      if current_user
        render json: calculated_reviews, status: 200
      else
        render json: { message: "not logged in" }, status: 422
      end
    end

    private

    def review_params
      params.require(:review).permit(:rental_id, :review, :review_text)
    end

    def calculated_reviews
      @calculated_reviews ||= ActiveRecord::Base.
        connection.
        execute(
          "SELECT
            users.id,
            users.username,
            COUNT(*) as total_count,
            AVG(reviews.review),
            SUM(CASE WHEN reviews.review = 1 THEN 1 ELSE 0 END) as one_stars,
            SUM(CASE WHEN reviews.review = 2 THEN 1 ELSE 0 END) as two_stars,
            SUM(CASE WHEN reviews.review = 3 THEN 1 ELSE 0 END) as three_stars,
            SUM(CASE WHEN reviews.review = 4 THEN 1 ELSE 0 END) as four_stars,
            SUM(CASE WHEN reviews.review = 5 THEN 1 ELSE 0 END) as five_stars
          FROM
            users
          JOIN listings ON users.id = listings.lessor_id
          JOIN rentals ON listings.id = rentals.listing_id
          JOIN reviews ON rentals.id = reviews.rental_id
          WHERE users.id = #{current_user.id}
          GROUP BY users.id, users.username
          LIMIT 1",
        ).first
    end
  end
end
