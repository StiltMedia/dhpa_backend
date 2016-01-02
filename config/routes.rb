Rails.application.routes.draw do
  match "/403" => "errors#error403", via: [ :get, :post, :patch, :delete ]
  match "/404" => "errors#error404", via: [ :get, :post, :patch, :delete ]
  match "/500" => "errors#error500", via: [ :get, :post, :patch, :delete ]

  devise_for :users
  root 'home#index'
  get 'admin/' => 'admin/home#index'
  get 'about' => 'pages#about', as: "about"
  get 'hire-dhpa' => 'pages#hire_dhpa', as: "hire_dhpa"

  match '/contact',    to: 'contact#new', via: 'get'
  resources 'contact', only: [:new, :create]

  namespace :admin do
    resources :events, only: [:new, :create, :edit, :update] do
      resources :photos
    end
    resources :settings
  end

  resources :events, only: [:index, :show]
  resources :line_items, only: [:new, :create, :edit, :update, :destroy]
  resources :photos, only: [:show]
  resources :payment_infos, only: [:create]

  get 'checkout', to: 'payment_infos#new'
  get 'confirm', to: 'orders#new'
  post 'confirm', to: 'orders#create'
  get 'cart', to: 'carts#show'
  get 'create_guest_user', to: 'orders#create_guest_user'
  get 'purchased/:order_id', to: 'purchases#show', as: "purchased"
end
