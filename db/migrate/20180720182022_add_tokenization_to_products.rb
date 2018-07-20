class AddTokenizationToProducts < ActiveRecord::Migration[5.1]
  def change
  	add_column :products, :search_token, :text
  end
end
