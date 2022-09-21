# frozen_string_literal: true

# Order model file
class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  enum payment: %i[cash card]
  validates :firstname, :lastname, :email, :address, presence: true
end
