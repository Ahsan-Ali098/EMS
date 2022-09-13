# frozen_string_literal: true

# discount model file
class Discount < ApplicationRecord
  paginates_per 5
  has_many :product

  def self.search(search)
    Discount.where('cast(id as text) LIKE :value or
    lower(discounts.name) LIKE :value or
    cast(discounts.price as text) LIKE :value ',
                   value: "%#{search.downcase}%")
  end
end
