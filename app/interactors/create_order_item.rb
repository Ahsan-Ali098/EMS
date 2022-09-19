# frozen_string_literal: true

class CreateOrderItem < ApplicationInteractor
  delegate :product_id, :current_cart, to: :context
  delegate :order_item, to: :context

  def call # rubocop:disable Metrics/MethodLength
    chosen_product = Product.find(product_id)
    if current_cart.products.include?(chosen_product)
      context.order_item = current_cart.order_items.find_by(product_id: chosen_product)
      order_item.quantity += 1
    else
      context.order_item = OrderItem.new
      order_item.cart = current_cart
      order_item.product = chosen_product
      order_item.order = current_order
    end

    order_item.save
  end
end
