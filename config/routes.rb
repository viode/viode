# frozen_string_literal: true

Rails.application.routes.draw do
  root 'questions#index'

  devise_for :users, skip: %i[sessions registrations]
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

  concern :subscribable do
    member do
      post :subscribe
      post :unsubscribe
    end
  end

  get '/ask', to: redirect('/questions/new')
  get '/q/:id', to: redirect('/questions/%{id}'), as: :question_short
  get '/settings', to: redirect('/settings/profile')
  get '/search', to: 'search#index', as: :search

  namespace :admin do
    root 'dashboard#show', as: :dashboard
  end

  namespace :settings do
    resource :account, only: %i[show update]
    resource :profile, only: %i[show update]
    resource :password, only: %i[show update]
  end

  resources :tags, only: [:show], param: :name
  resources :categories, only: %i[index show], param: :permalink, concerns: :subscribable
  resources :users, only: [:show], param: :username do
    member do
      get :answers
      get :questions
    end
  end
  resources :questions, only: %i[index new create], concerns: :votable do
    post :star, on: :member
    resources :answers, only: %i[new create]
  end
  resources :answers, only: [], concerns: :votable

  get '/questions/*id(/:permalink)', to: 'questions#show', as: :question
end
