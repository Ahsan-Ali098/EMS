# frozen_string_literal: true

# Product Controller
class User
  # Class for ProductsController
  class ProductsController < ApplicationController
    def index
      @products = Product.all
    end
  end
end
