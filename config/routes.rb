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
    resources :order_items, only: %i[create new destroy show]
    resource  :carts, only: %i[show destroy]
    resources :orders
  end
  post 'order_items/:id/add' => 'order_items#add_quantity', as: 'order_item_add'
  post 'order_items/:id/reduce' => 'order_items#reduce_quantity', as: 'order_item_reduce'
  resources :invitations, only: %i[new create]
end
