# frozen_string_literal: true

# Product Controller
module Admin
  # Class for ProductsController
  class ProductsController < ApplicationController
    before_action :find_product, only: %i[show update edit destroy]

    def index
      @products = Product.all.page(params[:page])
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)
      if @product.save
        redirect_to admin_products_path
      else
        render 'new'
      end
    end

    def show; end

    def update
      if @product.update(product_params)
        redirect_to admin_products_path
      else
        render 'edit'
      end
    end

    def edit; end

    def destroy
      @product.destroy
      redirect_to admin_products_path
    end

    private

    def find_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(
        :title,
        :price,
        :description,
        :status,
        :category_id
      )
    end
  end
end
