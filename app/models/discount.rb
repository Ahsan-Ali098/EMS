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

  def self.validate_coupon(coupon, cart)
    value = Discount.find_by(name: coupon).present? ? Discount.find_by(name: coupon).price : 0

    if value.positive?
      count = cart.products.where('discount_id = ?', Discount.find_by(name: coupon).id).count
      value *= count
    end
    value
  end
end
