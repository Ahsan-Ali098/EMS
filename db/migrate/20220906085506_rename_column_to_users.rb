# frozen_string_literal: true

# Renaming Column in Users
class RenameColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :full_name, :user_name
  end
end
