# frozen_string_literal: true

module Api
  class ListingsController < ApplicationController
    include ActionView::Helpers::DateHelper

    def index
      listings = Listing.
        where(lessor: current_user).
        where(active: true).
        includes(:rentals, rentals: [:lessee]).
        order("rentals.start_date")

      return_hash = index_translate(listings)
      render json: return_hash, status: 200
    end

    def show
      listing = Listing.
        includes(:lessor, :brand, :category, :photos, :reviews, :rentals, reviews: :reviewer).
        find(params[:id])
      return render json: { error: "not found" }, status: 404 unless listing

      render json: show_translate(listing), status: 200
    end

    def create
      listing = Listing.new(listing_params)
      listing.lessor = current_user
      listing.brand = Brand.find_by(name: params[:listing][:brand])
      listing.category = Category.find_by(name: params[:listing][:category])
      if listing.save
        urls = params[:listing][:image_urls]
        urls&.each { |url| Photo.create(listing: listing, image_url: url) }
        render json: show_translate(listing), status: 200
      else
        render json: listing.errors.full_messages, status: 422
      end
    end

    private

    def index_translate(listings)
      return_hash = {}
      listings.each do |listing|
        return_hash[listing.id] = listing.rentals.map do |rental|
          {
            id:         rental.id,
            start_date: rental.start_date,
            end_date:   rental.end_date,
            total:      rental.total,
            lessee:     rental.lessee.username,
          }
        end
      end
      return_hash
    end

    def show_translate(listing)
      {
        id: listing.id,
        lessor: listing.lessor.username,
        brand: listing.brand.name,
        category: listing.category.name,
        listing_title: listing.listing_title,
        detail_desc: listing.detail_desc,
        location: listing.location,
        lat: listing.lat,
        lng: listing.lng,
        day_rate: listing.day_rate,
        replacement_value: listing.replacement_value,
        serial: listing.serial,
        rating_average: listing.rating_average,
        review_count: listing.review_count,
        photos: listing.photos.to_a,
        reviews: listing.
          reviews.
          sort { |x, y| y.created_at <=> x.created_at }.
          map do |review|
            {
              id:           review.id,
              lessee:       review.reviewer.username,
              date:         time_ago_in_words(review.created_at),
              rating:       review.review,
              review_text:  review.review_text,
            }
          end,
        rentals: listing.rentals.sort { |x, y| y.start_date <=> x.start_date },
      }
    end

    def listing_params
      params.require(:listing).
        permit(:listing_title,
               :detail_desc,
               :location,
               :lat,
               :lng,
               :day_rate,
               :replacement_value,
               :serial)
    end
  end
end
