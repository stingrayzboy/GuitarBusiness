class Accessory < Product
	validates :name, presence: true
	validates :characteristic, presence: true
	validates :price, presence: true
	validates :accessory_count, presence: true	
end
