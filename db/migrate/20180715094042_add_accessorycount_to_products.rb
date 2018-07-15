class AddAccessorycountToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :accessory_count, :integer
  end
end
