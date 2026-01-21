Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  authenticated :user do
    root to: "dashboard/overview#index", as: :authenticated_root
  end
  root "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check

  namespace :dashboard do
    root to: "overview#index"
    resource :profile, only: [ :show, :edit, :update ]

    resources :bookings, only: [ :index, :show ]

    resources :services do
      resources :bookings, only: [ :new, :create ]
    end
  end

  get "/p/:slug", to: "providers#show", as: :provider

  resources :bookings, only: [ :index, :show ] do
    member do
      patch :confirm, to: "bookings_status#confirm"
      patch :cancel, to: "bookings_status#cancel"
    end
  end

  get "/booking/success", to: "bookings#success", as: :booking_success

  resource :availability, only: [ :show, :edit, :update ]
  resource :profile, only: [ :show, :edit, :update ]
end
