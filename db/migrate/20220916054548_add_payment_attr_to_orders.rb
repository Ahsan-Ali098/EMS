class AddPaymentAttrToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :payment, :integer, deafult: 0
  end
end
