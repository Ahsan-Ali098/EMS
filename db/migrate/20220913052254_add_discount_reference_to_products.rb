# frozen_string_literal: true

# Adding discount refernce to products
class AddDiscountReferenceToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :discount
  end
end
