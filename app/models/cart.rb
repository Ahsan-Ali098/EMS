# frozen_string_literal: true

# Cart model file
class Cart < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  belongs_to :user

  def sub_total
    sum = 0
    order_items.each do |order_item|
      sum += order_item.total_price
    end
    sum
  end

  def empty
    order_items.destroy_all
  end
end
