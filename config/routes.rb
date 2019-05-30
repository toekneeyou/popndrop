Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users,
  controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :toilets do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, only: [:index, :show, :destroy, :update] do
      resources :reviews, only: [:new, :create]
  end

  resources :users do
    resources :reviews, only: [:new, :create]
  end

  namespace :poopspace, only: [:show, :update, :destroy] do
    resources :users, only: [:show, :update, :destroy]
    resources :toilets, only: [:index]
    resources :bookings, only: [:index, :update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
