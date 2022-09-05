# frozen_string_literal: true
Rails.application.routes.draw do
  devise_for :admins
  namespace :admin do
  resources :users
  end
end
