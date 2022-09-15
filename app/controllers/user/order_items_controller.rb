# frozen_string_literal: true

# User namespace
class User
  # OrderItemsController
  class OrderItemsController < ApplicationController
    def create
      # Find associated product and current cart
      chosen_product = Product.find(params[:product_id])
      current_cart = @current_cart

      # If cart already has this product then find the relevant order_item and iterate quantity otherwise create a new order_item for this product
      if current_cart.products.include?(chosen_product)
        # Find the order_item with the chosen_product
        @order_item = current_cart.order_items.find_by(product_id: chosen_product)
        # Iterate the order_item's quantity by one
        @order_item.quantity += 1
      else
        @order_item = OrderItem.new
        @order_item.cart = current_cart
        @order_item.product = chosen_product
        @order_item.order = current_order
      end
      # Save and redirect to cart show path
      @order_item.save
      redirect_to user_carts_path(current_cart)
    end

    def destroy
      @order_item = OrderItem.find(params[:id])
      @order_item.destroy
      redirect_to user_carts_path(@current_cart)
    end

    private

    def order_item_params
      params.require(:order_item).permit(:quantity, :product_id, :cart_id)
    end
  end
end
