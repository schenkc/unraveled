Unraveled::Application.routes.draw do
  get 'users/activate' => 'users#activate_user'
  root to: 'sessions#new'
  resources :users, only: [:new, :create, :show, :edit, :update, :index] do
    resources :patterns, only: [:index]
    resources :followers, only: [:create, :destroy]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :patterns do
    resources :user_liked_patterns, only: [:create]
  end
  resources :user_liked_patterns, only: [:destroy]

  resources :tags, only: [:create]

  get 'patterns/:id/pdf' => 'patterns#pdf'
  get 'search' => 'patterns#search'


end
