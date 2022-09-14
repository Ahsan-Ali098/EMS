# frozen_string_literal: true

# Crering orders table migration
class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.text :address

      t.timestamps
    end
  end
end
