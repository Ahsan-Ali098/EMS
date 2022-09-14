# frozen_string_literal: true

# Adding roles in user
class AddRoleToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :integer, default: 0
  end
end
