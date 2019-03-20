Rails.application.routes.draw do
  resources :currencies, only: [:index]
  resources :conversions, only: [:create]
end

