class Item < ActiveRecord::Base
	belongs_to :wishlist


	before_create :get_etsy_id, :set_attributes_from_etsy

	# , :get_pictures_from_etsy 

	def get_etsy_id
		string = self.etsy_url
		regex = /\d+/
		numbers = string.scan(regex)
		self[:etsy_id] = numbers[0]

	end

	# def set_attributes_from_etsy
	# 	etsy_data = get_etsy_data
	# 	listing = etsy_data["results"][0]
	# 	self[:name] = listing["title"]
	# 	self[:description] = listing["description"]
	# 	self.save
	# end

	def set_attributes_from_etsy
		etsy_data = get_etsy_data
		listing = etsy_data["results"][0]
		self[:name] = listing["title"]
		self[:description] = listing["description"]
		self[:price] = listing["price"]
		self[:quantity] = listing["quantity"]
		# self[:style] = listing["style"]
		self[:views] = listing["views"]
		self[:photo_pic] = get_pictures_from_etsy
		
	end

	def get_pictures_from_etsy

  	response = HTTParty.get("https://openapi.etsy.com/v2/listings/#{self.etsy_id}/images?api_key=#{Rails.application.secrets.etsy_api_key}")
		images = response["results"]
  	images[0]["url_170x135"] 
	end

	# def sellers_avatar_from_etsy
	# 	response = HTTParty.get("https://openapi.etsy.com/v2/listings/#{self.etsy_id}/images?api_key=#{Rails.application.secrets.etsy_api_key}")
	# 	images = response["results"]
	# 	images[0]["url_170x135"]
	# end



	# def set_attributes_from_etsy
	# 	etsy_data = get_etsy_data
	# 	listing = etsy.data("results")[0]
	# 	self[:name] = etsy_data["results"][0]["title"]
	# 	self[:description] = etsy_data["results"][0]["description"]
	# 	self.save
	# end

	# def set_description_from_etsy
	# 	etsy_data = get_etsy_data
	# 	self[:description] = etsy_data["results"][0]["description"]
	# 	self.save
	# end

	def get_etsy_data
		HTTParty.get("https://openapi.etsy.com/v2/listings/#{self.etsy_id}?api_key=#{Rails.application.secrets.etsy_api_key}")
  end



end

