# frozen_string_literal: true

# User namespace
class User
  # OrderItemsController
  class OrderItemsController < ApplicationController
    before_action :current_cart

    def create
      result = CreateOrderItem.call(
        product_id: params[:product_id],
        current_cart: @current_cart,
      )
      @order_item = result.order_item
      if result.success?
        redirect_to user_cart_path(@current_cart)
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
  end
end
