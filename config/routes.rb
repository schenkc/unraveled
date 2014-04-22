Unraveled::Application.routes.draw do
  get 'users/activate' => 'users#activate_user'
  root to: 'sessions#new'
  resources :users, only: [:new, :create, :show] do
    resources :patterns, only: [:index]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :patterns
end
