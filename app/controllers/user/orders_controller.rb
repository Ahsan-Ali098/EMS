# frozen_string_literal: true

# User
class User
  # Class Orders
  class OrdersController < ApplicationController
    before_action :current_cart
    def index
      @orders = Order.all
    end

    def show
      @order = Order.find(params[:id])
    end

    def new
      @order = Order.new
    end

    def create
      @order = Order.new(order_params)
      @current_cart.order_items.each do |item|
        @order.order_items << item
        item.cart_id = nil
      end
      @order.save
      # Cart.destroy(@current_cart.id)
      @current_cart.empty
      redirect_to admin_orders_path
    end

    private

    def order_params
      params.require(:order).permit(:firstname, :lastname, :email, :address)
    end
  end
end
