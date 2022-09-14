# frozen_string_literal: true

# Product
class Product < ApplicationRecord
  paginates_per 5
  belongs_to :discount, optional: true
  belongs_to :category
  has_one_attached :image
  enum status: %i[publish draft pending]

  def self.search_product(search)
    Product.where('cast(id as text) LIKE :value or lower(products.title) LIKE :value ',
                  value: "%#{search.downcase}%")
  end
end
