# frozen_string_literal: true

# Cart model file
class Cart < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :products, through: :line_items
end
