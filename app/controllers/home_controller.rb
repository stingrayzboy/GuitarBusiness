class HomeController < ApplicationController
  before_action :authenticate_user!,except:[:index]
  def index
    if logged_in?(:owner)
      @unsold_guitars=Guitar.where(sold:0)
      @sold_guitars=Guitar.where(sold:1)
      @accessories=Accessory.all
      #byebug
    else
      unless session[:cart]
    	 session[:cart]=[]
      end
    	@products=Product.includes(:images)
    	#byebug
    end
  end


  def cart
    session[:cart]<<params[:product]

  end

  def checkout
  	#byebug
  	logger.info(session[:cart])
  	if session[:cart].first.nil?
  		@message="you dont have any items to checkout with"
  	else
  		@products=[]
      session[:cart].each do |prod|
        @products<<Product.find(prod)
      end 
      @message="Items in your Cart"
  	end
  end

  def pay
    last_purchase=Purchase.last
    if last_purchase.nil?
      purc=0
    else
      purc=last_purchase.purchase_id.to_i
    end
    session[:cart].each do|p|
      @p=Purchase.create!(purchase_id:purc+1,product:Product.find(p),user:current_user)
    end
    @purchases=Purchase.where(purchase_id:@p.purchase_id).includes(:product)
    session[:cart]=[]
  end

  def reset
    session[:cart]=[]
    redirect_to root_path
  end

  def orders
    @p=Purchase.select("DISTINCT(purchase_id)").where(user:current_user).pluck(:purchase_id).uniq

  end

  def bills
    @purchasess=Purchase.where(purchase_id:params[:id]).includes(:product)
  end
end
