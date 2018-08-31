# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "static_pages#root"

  namespace :api, defaults: { format: :json } do
    resources :users, only: %i[create index]
    resource :session, only: %i[new create destroy]
    resources :listings, only: %i[index show update create]
    resources :rentals, only: %i[index create]
    resources :search, only: [:index]
    resources :options, only: [:index]
    resources :reviews, only: [:create]
  end
end
