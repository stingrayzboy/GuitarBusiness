class Product < ApplicationRecord
	has_many :purchases
	has_many :users, through: :purchases
	enum sold:{yes:1,no:0}
	has_many :images,as: :imageable, dependent: :destroy
 	accepts_nested_attributes_for :images
end
