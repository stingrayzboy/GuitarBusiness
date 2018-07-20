class Accessory < Product
	validates :name, presence: true
	validates :characteristic, presence: true
	validates :price, presence: true
	validates :accessory_count, presence: true	

	before_save :tokenization

	def tokenization
		self.search_token="#{self.name}|#{self.characteristic}"
	end
end
