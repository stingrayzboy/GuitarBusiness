class AddProductAndUserToPurchases < ActiveRecord::Migration[5.1]
  def change
    add_reference :purchases, :product, foreign_key: true
    add_reference :purchases, :user, foreign_key: true
  end
end
