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
      @current_cart.empty
      redirect_to user_products_path
    end
  end
end
