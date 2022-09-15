# frozen_string_literal: true

# Product Controller
class User
  # Class for ProductsController
  class ProductsController < ApplicationController
    before_action :current_cart
    def index
      @products = Product.all
    end
  end
end
