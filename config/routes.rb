# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/index'
  get 'users/edit'
  get 'users/new'
  get 'users/show'
  root to: 'home#index'
  devise_for :users
end
