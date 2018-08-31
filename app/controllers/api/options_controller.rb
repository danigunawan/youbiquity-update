# frozen_string_literal: true

module Api
  class OptionsController < ApplicationController
    def index
      brands = Brand.all.pluck(:name)
      categories = Category.all.pluck(:name)
      return_hash = {
        brand_options: brands,
        category_options: categories,
      }

      render json: return_hash, status: 200
    end
  end
end
