Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :products, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :orders, only: [:index, :edit, :show, :new, :create, :update] do
    resources :order_products, only: [:new, :create, :update, :edit, :destroy]
  end
  resources :events, only: [:index, :edit, :show, :new, :create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
