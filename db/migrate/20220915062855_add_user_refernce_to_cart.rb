# frozen_string_literal: true

# Adding refernece in cart
class AddUserRefernceToCart < ActiveRecord::Migration[5.2]
  def change
    add_reference :carts, :user, foreign_key: true
  end
end
