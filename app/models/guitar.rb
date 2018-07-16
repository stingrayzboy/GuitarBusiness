class Guitar < Product
	validates :model, presence: true
	validates :brand, presence: true
	enum guitar_type:{  classic:0,	electric:1	}
	enum sold:{  sold_no:0,	sold_yes:1	} 
	validates :price, presence: true
	validates :serial, {presence: true,uniqueness: true}
	validates :accessory_count, presence: true
end
