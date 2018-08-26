# frozen_string_literal: true

module Api
  class OptionsController < ApplicationController
    def index
      @brands = Brand.all.pluck(:name)
      @categories = Category.all.pluck(:name)
    end
  end
end
