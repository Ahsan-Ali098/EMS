# frozen_string_literal: true

# Class creating carts
class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts, &:timestamps
  end
end
