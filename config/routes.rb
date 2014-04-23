Unraveled::Application.routes.draw do
  get 'users/activate' => 'users#activate_user'
  root to: 'sessions#new'
  resources :users, only: [:new, :create, :show, :edit, :update] do
    resources :patterns, only: [:index]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :patterns do
    resources :libraries, only: [:create]
  end
  resources :libraries, only: [:destroy]
end
