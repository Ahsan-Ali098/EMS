# frozen_string_literal: true

# Order model file
class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  enum payment: %i[cash card]
  enum status: %i[complete pending]
  validates :firstname, :lastname, :email, :address, presence: true, on: :update
end
