Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :toys, only: [:index, :new, :create, :show] do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, except: [:new, :create] do
    member do
      patch :update_status
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
