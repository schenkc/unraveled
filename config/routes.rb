Unraveled::Application.routes.draw do
  get 'users/activate' => 'users#activate_user'
  root to: 'sessions#new'
  resources :users, only: [:new, :create, :show, :edit, :update, :index, :destroy] do
    resources :patterns, only: [:index]
    resources :followers, only: [:create, :destroy]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :patterns do
    resources :user_liked_patterns, only: [:create]
    get 'pdf', on: :member
  end
  resources :user_liked_patterns, only: [:destroy]

  resources :tags, only: [:create]
  resources :notifications, only: [:index, :show]
  resources :messages, only: [:index]
  # do
  # get 'thread', on: :member
  # end
  get 'search' => 'patterns#search'
  namespace :api, defaults: { formate: :json } do
    resources :messages
  end


end
