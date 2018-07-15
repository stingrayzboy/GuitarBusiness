class Product < ApplicationRecord
	has_many :purchases
	has_many :users, through: :purchases
	has_many :images,as: :imageable, dependent: :destroy
	enum sold:{yes:1,no:0}
 	accepts_nested_attributes_for :images
end
