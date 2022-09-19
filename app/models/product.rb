# frozen_string_literal: true

# Product
class Product < ApplicationRecord
  paginates_per 5
  has_many :order_items, dependent: :destroy
  belongs_to :discount, optional: true
  belongs_to :category
  has_one_attached :image
  enum status: %i[publish draft pending]
  validates :title, :price, :description, presence: true

  def self.search_product(search)
    Product.where('cast(id as text) LIKE :value or lower(products.title) LIKE :value ',
                  value: "%#{search.downcase}%")
  end
end
