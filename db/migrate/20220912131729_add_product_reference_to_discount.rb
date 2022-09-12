# frozen_string_literal: true

# Adding refernce in discount
class AddProductReferenceToDiscount < ActiveRecord::Migration[5.2]
  def change
    add_reference :discounts, :products, foreign_key: true
  end
end
