# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  namespace :admin do
    resources :users
    resources :products
  end
end
