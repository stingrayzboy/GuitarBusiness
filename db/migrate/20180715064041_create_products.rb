class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :model
      t.string :type
      t.integer :guitar_type,default: 0
      t.decimal :price
      t.string :characteristic
      t.string :serial
      t.string :brand
      t.integer :sold,default: 0
      t.timestamps
    end
  end
end
