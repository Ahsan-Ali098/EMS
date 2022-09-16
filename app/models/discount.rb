# frozen_string_literal: true

# discount model file
class Discount < ApplicationRecord
  paginates_per 5
  has_many :products
  validates :name, :price, presence: true

  def self.search(search)
    Discount.where('cast(id as text) LIKE :value or
    lower(discounts.name) LIKE :value or
    cast(discounts.price as text) LIKE :value ',
                   value: "%#{search.downcase}%")
  end

  def discount_for_products(products)
    products = products.compact.reject!(&:empty?)
    Product.where(id: products).update_all(discount_id: id)
  end

  def self.apply_discount(params)
    price = Discount.find_by(name: params).price
  end
end
