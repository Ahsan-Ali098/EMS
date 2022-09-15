# frozen_string_literal: true

# Order model file
class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
end
