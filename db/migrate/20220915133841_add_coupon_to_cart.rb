class AddCouponToCart < ActiveRecord::Migration[5.2]
  def change
    add_column :carts, :coupon, :float
  end
end
