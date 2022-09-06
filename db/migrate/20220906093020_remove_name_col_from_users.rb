# frozen_string_literal: true

# Removing Columns from Users
class RemoveNameColFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
  end
end
