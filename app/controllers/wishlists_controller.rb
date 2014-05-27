class WishlistsController < ApplicationController

	before_filter :load

	def load
		@wishlists = Wishlist.all
    @new_wishlist = Wishlist.new
	end
	def index
		@wishlists = current_user.wishlists.all
		# this will only assign the current_users wishlist  
	end



	def show
		@wishlist = Wishlist.find(params[:id])
	end


    


	def create
		@wishlist = WishList.new 
		# @wishlist[:user_id] = current_user.id
		@wishlist = current_user.wishlists.build(wishlist_params)
		if @wishlist.save
			respond_to do |format|
      format.js  { render json: @wishlist }
      format.html 
    end
		else
			respond_to do |format|
      format.js 
      format.html { redirect_to wishlists_path, notice: "update failed." }
		end
	end
end

  def edit
    @wishlist = Wishlist.find(params[:id])
  end

  def new
  	@wishlist = Wishlist.new

  end

 
  def update
    @wishlist = Wishlist.find(params[:id])
    if @wishlist.update_attributes(wishlist_params)
      @wishlists = Wishlist.all
    else
      render :json => @wishlist.errors
    end
  end

  def destroy
	    @wishlist = Wishlist.find(params[:id])
      
	    if @wishlist.destroy
	    respond_to do |format|
	      format.html { redirect_to wishlists_path }
	      format.js { render json: @wishlist }
	      @wishlists = Wishlist.all
	    end
	    else 
	    respond_to do |format|
        flash.now[:notice] = "Successfully created post."
	      format.html { redirect_to wishlists_path, notice: "update failed." }
	      format.js  
	    end
	  end
  end

	private

	def wishlist_params
		params.require(:wishlist).permit!
	end
end
