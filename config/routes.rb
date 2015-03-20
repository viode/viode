Rails.application.routes.draw do
  devise_for :users, skip: [:sessions, :registrations]
  devise_scope :user do
    get     'login'  => 'devise/sessions#new',     as: :new_user_session
    post    'login'  => 'devise/sessions#create',  as: :user_session
    delete  'logout' => 'devise/sessions#destroy', as: :destroy_user_session
    get   'register' => 'devise/registrations#new',    as: :new_user_registration
    post  'register' => 'devise/registrations#create', as: :user_registration
  end

  resources :questions, only: [:index, :show, :new, :create]

  root 'home#index'
end
