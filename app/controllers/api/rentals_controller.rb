# frozen_string_literal: true

module Api
  class RentalsController < ApplicationController
    def index
      rentals = Rental.
        where(lessee: current_user).
        includes(:lessor, :listing, :review).
        order(:start_date)

      render json: translate_index(rentals), status: 200
    end

    def create
      rental = Rental.new(rental_params)
      rental.lessee_id = current_user.id
      rental.listing_id = params[:rental][:id]

      if rental.save
        render json: {
          id:         rental.id,
          start_date: rental.start_date,
          end_date:   rental.end_date,
          total:      rental.total,
          lessor:     rental.lessor.username,
        }, status: 200
      else
        render json: rental.errors.full_messages, status: 422
      end
    end

    private

    def rental_params
      params.require(:rental).permit(:start_date, :end_date)
    end

    def translate_index(rentals)
      {
        rentals: rentals.map do |rental|
          {
            id:         rental.id,
            lessor:     rental.lessor.username,
            listing_id: rental.listing.id,
            start_date: rental.start_date,
            end_date:   rental.end_date,
            total:      rental.total,
            rating:     rental.try(:review).try(:review),
            review:     rental.try(:review).try(:review_text),
          }
        end,
      }
    end
  end
end
