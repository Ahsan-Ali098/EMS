# frozen_string_literal: true

module Api
  # Product Controller
  module Admin
    # Class for ProductsController
    class ProductsController < ApplicationController
      before_action :set_product, only: %i[show update edit destroy]

      def index
        @products = Product.all
      end

      def new
        @product = Product.new
      end

      def create
        @product = Product.create(product_params)
      end

      def show; end

      def update
        @product.update(product_params)
      end

      def edit; end

      def destroy
        @product.destroy
      end

      private

      def set_product
        @product = Product.find(params[:id])
      end

      def product_params
        params.require(:product).permit(
          :id,
          :title,
          :price,
          :description,
          :status,
          :category_id,
          :image,
        )
      end
    end
  end
end
