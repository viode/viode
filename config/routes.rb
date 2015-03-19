Rails.application.routes.draw do
  devise_for :users

  resources :questions, only: [:index]

  root 'home#index'
end
