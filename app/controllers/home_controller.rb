class HomeController < ApplicationController
  def index
    if logged_in?(:owner)
      @unsold_guitars=Guitar.where(sold:0)
      @sold_guitars=Guitar.where(sold:1)
      @accessories=Accessory.all
      #byebug
    else
    	session[:cart]=[]
    	@guitars=Guitar.includes(:images)
    	@accessories=Accessory.includes(:images)
    	#byebug
    end
  end

  def checkout
  	#byebug
  	logger.info(session[:cart])
  	if session[:cart].first.nil?
  		@message="you dont have any items to checkout with"
  	else
  		@message="you may checkout"
  	end
  end

end
