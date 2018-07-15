class Guitar < Product
	validates :model, presence: true
	validates :brand, presence: true
	enum guitar_type:{  classic:0,	electric:1	} 
	validates :price, presence: true
	validates :serial, {presence: true,uniqueness: true}
end
