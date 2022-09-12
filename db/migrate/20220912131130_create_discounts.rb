# frozen_string_literal: true

# Discount  table
class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.string :name
      t.float :price

      t.timestamps
    end
  end
end
