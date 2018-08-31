# frozen_string_literal: true

module Api
  class SearchController < ApplicationController
    def index
      hash_return = {}
      listings.each do |listing|
        hash_return[listing["id_of_listing"]] = {
          id: listing["id_of_listing"],
          lessor: listing["lessor"],
          brand: listing["brand"],
          category: listing["category"],
          day_rate: listing["day_rate"],
          lat: listing["lat"],
          lng: listing["lng"],
          rating_average: listing["review_average"].to_f.round(1),
          review_count: listing["review_count"],
          photos: photos[listing["id_of_listing"]].map { |photo| { image_url: photo.image_url, id: photo.id } },
        }
      end
      render json: hash_return, status: 200
    end

    private

    def brand_filters
      params[:brand].map { |b| "'#{b}'" } unless params[:brand].blank?
    end

    def category_filters
      params[:category].map { |c| "'#{c}'" } unless params[:category].blank?
    end

    def price_filter
      params[:price] unless params[:price].blank?
    end

    def rating_filter
      params[:rating].to_i - 0.5 unless params[:rating].blank?
    end

    def bounds_filter
      params[:bounds] unless params[:bounds].blank?
    end

    def bounds_wrap_around?
      bounds_filter && bounds_filter[:southWest][:lng].to_f < bounds_filter[:northEast][:lng].to_f
    end

    def sql_joins
      "SELECT
        listings.id AS id_of_listing,
        users.username AS lessor,
        brands.name AS brand,
        categories.name AS category,
        listings.day_rate,
        listings.lat,
        listings.lng,
        listings.listing_title,
        AVG(reviews.review) AS review_average,
        COUNT(reviews.review) AS review_count
      FROM
        listings
      JOIN users ON users.id = listings.lessor_id
      JOIN brands ON brands.id = listings.brand_id
      JOIN categories ON categories.id = listings.category_id
      JOIN rentals ON rentals.listing_id = listings.id
      JOIN reviews ON reviews.rental_id = rentals.id"
    end

    def sql_wheres
      sql_statement = "WHERE listings.active = TRUE"
      sql_statement += " AND brands.name IN (#{brand_filters.join(',')})" if brand_filters
      sql_statement += " AND categories.name IN (#{category_filters.join(',')})" if category_filters
      sql_statement += " AND listings.day_rate <= #{price_filter}" if price_filter

      if bounds_wrap_around?
        sql_statement +=
          " AND listings.lat > #{bounds_filter[:southWest][:lat]}" \
          " AND listings.lat < #{bounds_filter[:northEast][:lat]}"
      elsif bounds_filter
        sql_statement +=
          " AND listings.lat > #{bounds_filter[:southWest][:lat]}" \
          " AND listings.lat < #{bounds_filter[:northEast][:lat]}" \
          " AND listings.lng > #{bounds_filter[:southWest][:lng]}" \
          " OR listings.lng < #{bounds_filter[:northEast][:lng]}"
      end
      sql_statement
    end

    def sql_group_bys
      sql_statement = "GROUP BY
        listings.id,
        lessor,
        brand,
        category"
      sql_statement += " HAVING AVG(reviews.review) >= #{rating_filter}" if rating_filter
      sql_statement
    end

    def listings
      @listings ||= ActiveRecord::Base.
        connection.
        execute([sql_joins, sql_wheres, sql_group_bys].join("\n"))
    end

    def photos
      @photos ||= Photo.
        where(listing_id: listings.pluck("id_of_listing")).
        each_with_object(Hash.new { |h, k| h[k] = [] }) { |photo, hash| hash[photo.listing_id] << photo }
    end
  end
end
