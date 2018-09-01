# frozen_string_literal: true

module Api
  class RentalsController < ApplicationController
    def index
      return render json: { error: "not logged in" }, status: 401 unless current_user

      rentals = Rental.
        where(lessee: current_user).
        includes(:lessor, :listing, :review).
        order(:start_date)

      render json: translate_index(rentals), status: 200
    end

    def create
      if (begin
            Date.parse(params[:rental][:start_date])
          rescue StandardError
            nil
          end).nil?
        return render json: ["Must enter both dates"], status: 422
      end
      listing = Listing.find(params[:rental][:id])
      rental = Rental.new(rental_params)
      rental.lessee_id = current_user.id
      rental.listing = listing
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
