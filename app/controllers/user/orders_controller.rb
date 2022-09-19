# frozen_string_literal: true

# User
class User
  # Class Orders
  class OrdersController < ApplicationController
    before_action :set_order, only: %i[show]
    before_action :current_cart
    def index
      @orders = Order.order(name: :desc)
    end

    def show; end

    def new
      value = Discount.validate_coupon(params[:coupon], current_cart) if params[:coupon].present?
      @coupon = @current_cart.sub_total.to_i - value.to_i
      @order = Order.new
    end

    def create
      @order = Order.new(order_params)
      @current_cart.order_items.each do |item|
        @order.order_items << item
      end
      @order.save
      @current_cart.empty
      redirect_to admin_orders_path
    end

    private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:firstname, :lastname, :email, :address, :payment)
    end
  end
end
