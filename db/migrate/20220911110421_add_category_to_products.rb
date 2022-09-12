# frozen_string_literal: true

# Adding categories in Products
class AddCategoryToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :category, foreign_key: true
  end
end
