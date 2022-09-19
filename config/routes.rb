# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, controllers: { registrations: 'registrations' }
  namespace :admin do
    resources :users
    resources :products
    resources :categories
    resources :discounts
    resources :orders, only: %i[index show]
  end

  namespace :user do
    resources :products, only: [:index]
    resources :order_items, only: %i[create new destroy show]
    resources :carts, only: %i[show destroy]
    resources :orders
  end
  post 'user/orders/discount', to: 'user/orders#discount', as: 'orders_coupon'
  resources :invitations, only: %i[new create]
end
