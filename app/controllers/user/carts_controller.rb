# frozen_string_literal: true

# UserNamespace
class User
  # Carts
  class CartsController < ApplicationController
    before_action :current_cart, only: %i[show destroy]

    def show; end

    def destroy
      @current_cart.empty
      redirect_to user_products_path
    end
  end
end
