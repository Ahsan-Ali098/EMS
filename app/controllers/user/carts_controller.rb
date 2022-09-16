# frozen_string_literal: true

# UserNamespace
class User
  # Carts
  class CartsController < ApplicationController
    before_action :current_cart
    def show
      @cart = @current_cart
    end

    def destroy
      @cart = @current_cart
      @cart.destroy
      session[:cart_id] = nil
      redirect_to root_path
    end

    def discount
      total = current_cart.sub_total(params[:cart][:coupon])
      redirect_to 'show'
    end

  end
end
