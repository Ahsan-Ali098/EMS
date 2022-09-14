# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  namespace :admin do
    resources :users
    resources :products
    resources :categories
    resources :discounts
  end

  namespace :user do
    resources :products, only: [:index]
    resources :order_items, only: %i[create new destroy]
    resources :carts, only: %i[show destroy]
    resources :orders
  end
end
