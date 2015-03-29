Rails.application.routes.draw do
  devise_for :users, skip: [:sessions, :registrations]
  devise_scope :user do
    get     'login'  => 'devise/sessions#new',     as: :new_user_session
    post    'login'  => 'devise/sessions#create',  as: :user_session
    delete  'logout' => 'devise/sessions#destroy', as: :destroy_user_session
    get   'register' => 'devise/registrations#new',    as: :new_user_registration
    post  'register' => 'devise/registrations#create', as: :user_registration
  end

  concern :votable do
    member do
      post :upvote
      post :downvote
    end
  end

  get '/settings', to: redirect('/settings/account')
  namespace :settings do
    resource :account, only: [:show, :update]
    resource :profile, only: [:show, :update]
    resource :password, only: [:show, :update]
  end

  resources :categories, only: [:index, :show]
  resources :users, only: [:show], param: :username
  resources :questions, only: [:index, :new, :create], concerns: :votable do
    resources :answers, only: [:new, :create]
  end
  resources :answers, only: [], concerns: :votable

  get '/questions/*id(/:permalink)', to: 'questions#show', as: :question

  root 'questions#index'
end
