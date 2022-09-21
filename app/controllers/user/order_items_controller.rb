# frozen_string_literal: true

# User namespace
class User
  # OrderItemsController
  class OrderItemsController < ApplicationController
    before_action :current_cart
    before_action :current_order

    def create
      result = CreateOrderItem.call(
        product_id: params[:product_id],
        current_cart: @current_cart, current_order: current_order
      )
      @order_item = result.order_item
      if result.success?
        redirect_to user_cart_path(@current_cart)
      else
        redirect_to user_products_path, alert: 'Error: Something went wrong.'
      end
    end

    def destroy
      @order_item = OrderItem.find(params[:id])
      @order_item.destroy
      redirect_to user_cart_path(@current_cart)
    end

    private

    def order_item_params
      params.require(:order_item).permit(:quantity, :product_id, :cart_id)
    end

    def current_order
      Order.find_or_create_by(user_id: params[:id])
    end
  end
end
