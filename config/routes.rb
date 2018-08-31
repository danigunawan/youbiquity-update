# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "static_pages#root"

  namespace :api, defaults: { format: :json } do
    resource  :session,   only: %i[new create destroy]
    resources :users,     only: %i[index create]
    resources :listings,  only: %i[index show update create]
    resources :rentals,   only: %i[index create]
    resources :search,    only: %i[index]
    resources :options,   only: %i[index]
    resources :reviews,   only: %i[create]

    get "my_reviews", action: :my_reviews, controller: "reviews"
  end
end
