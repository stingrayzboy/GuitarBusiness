class Purchase < ApplicationRecord
	belongs_to :user
	belongs_to :product
	#validates_uniqueness_of :purchase_id
end
