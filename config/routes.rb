Rails.application.routes.draw do
  root "pages#home"

  devise_for :users,
            path: "",
            path_names: {sign_in: "login", sign_out: "logout", edit: "profile"},
            controllers: {omniauth_callbacks: "omniauth_callbacks", registrations: "registrations"}
  resources :users, only: [:show]
  resources :rooms, except: [:edit] do
    member do
      get "listing"
      get "pricing"
      get "description"
      get "photo_upload"
      get "amenities"
      get "location"
      get "preload"
      get "preview"
    end
    resources :photos, only: [:create, :destroy]
    resources :reservations, only: [:create]
    resources :calendars
  end

  resources :reviews, only: [:create, :destroy]
  resources :guest_reviews, only: [:create, :destroy]
  resources :host_reviews, only: [:create, :destroy]

  get "/your_trips", to: "reservations#your_trips"
  get "/your_reservations", to: "reservations#your_reservations"
  get "/search", to: "pages#search"
  get "/dashboard", to: "dashboards#index"

  resources :reservations, only: [:approve, :decline] do
    member do
      post "/approve", to: "reservations#approve"
      post "/decline", to: "reservations#decline"
    end
  end

  resources :revenues, only: [:index]

  get "/host_calendar", to: "calendars#host"

  get "/notifications", to: "notifications#index"

  resources :conversations, only: [:create, :index] do
    resources :messages, only: [:create, :index]
  end

  mount ActionCable.server => "/cable"
end
