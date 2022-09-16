# frozen_string_literal: true

# Cart model file
class Cart < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  belongs_to :user

  def sub_total (dis= nil)
    total = 0
    byebug
    order_items.each do |order_item|
      total += order_item.total_price
    end
      discount =Discount.apply_discount(dis) if dis
    total-=discount.to_i
  end

  def empty
    order_items.destroy_all
    total = 0
  end
end
