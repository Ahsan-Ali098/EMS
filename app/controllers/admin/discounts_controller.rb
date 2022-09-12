# frozen_string_literal: true

# Discount Controller
module Admin
  # Class for DiscountsController
  class DiscountsController < ApplicationController
    before_action :set_discount, only: %i[show update edit destroy]

    def index
      @discounts = Discount.order(name: :desc)
    end

    def new
      @discount = Discount.new
    end

    def create
      @discount = Discount.new(discount_params)
      if @discount.save
        redirect_to admin_discounts_path
      else
        render 'new'
      end
    end

    def show; end

    def update
      if @discount.update(discount_params)
        redirect_to admin_discounts_path
      else
        render 'edit'
      end
    end

    def edit; end

    def destroy
      @discount.destroy
      redirect_to admin_discounts_path
    end

    private

    def set_discount
      @discount = Discount.find(params[:id])
    end

    def discount_params
      params.require(:discount).permit(:name, :price, :products_id)
    end
  end
end
