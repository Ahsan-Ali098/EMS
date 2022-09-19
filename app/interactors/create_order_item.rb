# frozen_string_literal: true

class CreateOrderItem < ApplicationInteractor
  delegate :product_id, :current_cart, :current_order, to: :context
  delegate :order_item, to: :context

  def call
    context.order_item = if current_cart.products.include?(chosen_product)
                           current_cart.order_items.find_by(product_id: chosen_product).increment!(:quantity)
                         else
                           OrderItem.create(cart: current_cart, product: chosen_product, order: current_order)
                         end
  end

  private

  def chosen_product
    Product.find(product_id)
  end
end
