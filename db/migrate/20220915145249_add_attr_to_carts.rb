class AddAttrToCarts < ActiveRecord::Migration[5.2]
  def change
    add_column :carts, :total, :integer, default: 0
  end
end
