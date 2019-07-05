Rails.application.routes.draw do
  resources :location_check, only: :create
  resources :areas, only: :index
end
