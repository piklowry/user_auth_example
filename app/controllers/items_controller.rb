class ItemsController < ApplicationController


	def new
		@item = Item.new
		response = HTTParty.get("https://openapi.etsy.com/v2/shops/heartfeltgiver/listings/active?method=GET&api_key=tygveg1ntsn1202u25mozuwe&fields=title,limit=100&includes=MainImage")
		@listing = response["results"]
	end

	def show
		@item = Item.find(params[:id])
		response = HTTParty.get("https://openapi.etsy.com/v2/listings/#{@item.etsy_id}/images?api_key=#{Rails.application.secrets.etsy_api_key}")
		@images = response["results"]
		# debugger

		@atom_feed = HTTParty.get("https://openapi.etsy.com/v2/listings/active?api_key=#{Rails.application.secrets.etsy_api_key}")
		@user_feed = HTTParty.get("http://www.etsy.com/shop/louiseandco/rss")
	  response_listing = HTTParty.get("https://openapi.etsy.com/v2/shops/heartfeltgiver/listings/active?method=GET&api_key=tygveg1ntsn1202u25mozuwe&fields=title,limit=100&includes=MainImage")
		@listing = response_listing["results"]
	end



	def create
		@item = Item.new(item_params)
		if @item.save
			redirect_to wishlist_path(params[:wishlist_id]), notice: "Item added."
		else
			redirect_to :back, alert: "Failed to save."
		end
	end

	private

	def item_params
		params.require(:item).permit!
	end
end
