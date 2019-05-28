Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :toilets do
    resources :bookings, only: [:create]
  end

  resources :bookings, only: [:index, :show, :destroy, :update] do
      resources :reviews, only: [:create, :index, :show]
  end

  namespace :my do
    resources :toilets, only: [:index]
    resources :bookings, only: [:index, :update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
