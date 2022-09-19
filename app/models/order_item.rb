# frozen_string_literal: true

# Order_items model file
class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  belongs_to :order

  def total_price
    quantity * product.price
  end
end
