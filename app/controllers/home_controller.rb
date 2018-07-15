class HomeController < ApplicationController
  def index
  	session[:cart]=[]
  	@guitars=Guitar.includes(:images)
  	@accessories=Accessory.includes(:images)
  	#byebug
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
