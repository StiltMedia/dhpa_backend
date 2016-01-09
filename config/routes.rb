Rails.application.routes.draw do
  match "/403" => "errors#error403", via: [ :get, :post, :patch, :delete ]
  match "/404" => "errors#error404", via: [ :get, :post, :patch, :delete ]
  match "/500" => "errors#error500", via: [ :get, :post, :patch, :delete ]

  devise_for :users, :controllers => { :registrations => "user/registrations" }
  root 'home#index'
  get 'admin/' => 'admin/home#index', as: "admin"
  get 'about' => 'pages#about', as: "about"
  get 'hire-dhpa' => 'pages#hire_dhpa', as: "hire_dhpa"

  match '/contact',    to: 'contact#new', via: 'get'
  resources 'contact', only: [:new, :create]

  namespace :admin do
    resources :events, only: [:new, :create, :show, :update, :destroy] do
      resources :photos
    end
    resources :orders, only: [:index]
    resources :users
    resources :settings
  end

  resources :events, only: [:show]
  resources :lightboxes
  post '/lightboxes/(:id)/add', to: 'lightboxes#add', as: "add_to_lightbox"
  resources :line_items, only: [:new, :create, :edit, :update, :destroy]
  resources :photos, only: [:show]
  resources :payment_infos, only: [:create]

  get 'checkout', to: 'payment_infos#new'
  get 'confirm', to: 'orders#new'
  post 'confirm', to: 'orders#create'
  get 'cart', to: 'carts#show'
  post 'create_session_password', to: 'session#create_session_password'
  get 'create_guest_user', to: 'orders#create_guest_user'

  match '/search', to: 'search#search', via: "get", as: "search"
  match '/search/vip/:id', to: 'search#vip', via: "get", as: "search_vip"

  resources :purchases, only: [:index, :show]
end
