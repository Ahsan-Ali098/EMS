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
      order = current_order
      order.price = @current_cart.sub_total
      order.update(order_params)
      @current_cart.order_items.each do |item|
        order.order_items << item
        item.cart_id = nil
        item.save
      end
      order.status = 0
      order.save
      if order.payment == 'card'
        redirect_to user_order_path(order)
      else
        redirect_to root_path
      end
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
