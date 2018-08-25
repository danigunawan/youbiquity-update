# frozen_string_literal: true

module Api
  class SearchController < ApplicationController
    def index
      brand_filters = brand_params.empty? ? Brand.all.pluck(:name) : brand_params
      category_filters = category_params.empty? ? Category.all.pluck(:name) : category_params
      rating_filter = rating_params.empty? ? 0 : rating_params.to_i - 0.5
      price_filter = price_params.empty? ? 99_999 : price_params
      bounds_filter = bounds_params.empty? ? nil : bounds_params

      @listings = Listing.
        joins(:category, :brand, :rentals, :reviews, :photos).
        where(categories: { name: category_filters }).
        where(brands: { name: brand_filters }).
        where(active: true).
        where("day_rate <= ?", price_filter).
        group("listings.id").
        having("AVG(reviews.review) >= ?", rating_filter)

      @listings =
        if bounds_filter && bounds_filter[:southWest][:lng].to_f < bounds_filter[:northEast][:lng].to_f
          @listings.
            where("lat BETWEEN ? AND ?", bounds_filter[:southWest][:lat], bounds_filter[:northEast][:lat])
        elsif bounds_filter
          @listings.
            where("lat BETWEEN ? AND ?", bounds_filter[:southWest][:lat], bounds_filter[:northEast][:lat]).
            where("lng > ? OR lng < ?", bounds_filter[:southWest][:lng], bounds_filter[:northEast][:lng])
        end
    end

    private

    def brand_params
      params[:brand]
    end

    def category_params
      params[:category]
    end

    def rating_params
      params[:rating]
    end

    def bounds_params
      params[:bounds]
    end

    def price_params
      params[:price]
    end
  end
end
