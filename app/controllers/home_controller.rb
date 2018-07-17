class HomeController < ApplicationController
  before_action :authenticate_user!,except:[:index,:show]
  
  def index
    if logged_in?(:owner)
      @unsold_guitars=Guitar.where(sold:0)
      @sold_guitars=Guitar.where(sold:1)
      @accessories=Accessory.all
      #get the accessory key values
      @pie_chart=Product.all.select(:name,:accessory_count).pluck(:name,:accessory_count).to_h.reject{|k| k.nil?}
      #get the guitar key values
      @pie_chart.merge!(Product.all.select(:model,:accessory_count).pluck(:model,:accessory_count).to_h.reject{|k| k.nil?})

      #byebug
    else
      unless session[:cart]
    	 session[:cart]=[]
      end
    	@products=Product.where("accessory_count > '0'").includes(:images)
    	#byebug
    end
  end
  def show
    id=params[:id]
    @product=Product.find(id)
  end

  def cart
    session[:cart]<<params[:product]

  end

  def checkout
  	#byebug
  	logger.info(session[:cart])
  	if session[:cart].first.nil?
  		@message=""
      @flag=true
  	else
  		@products=[]
      session[:cart].each do |prod|
        @products<<Product.find(prod)
      end 
      @message="Items in your Cart"
  	end
  end

  def pay
  begin 
    last_purchase=Purchase.last
    if last_purchase.nil?
      purc=0
    else
      purc=last_purchase.purchase_id.to_i
    end
    session[:cart].each do|p|
      product=Product.find(p)

      if product[:accessory_count]>0
        @p=Purchase.create!(purchase_id:purc+1,product:product,user:current_user)
        
        product.type=='Guitar' ? product.update(accessory_count:(product.accessory_count-1),sold:1) : product.update(accessory_count:(product.accessory_count-1))
        

      else
        @notice='Some Products Couldnot be billed as they went out of Stock.Your Total amount got revised.' 
      end

    end
    @purchases=Purchase.where(purchase_id:@p.purchase_id).includes(:product)
  rescue
    redirect_to root_path
  end
    session[:cart]=[]
  end

  def reset
    session[:cart]=[]
    redirect_to root_path
  end

  def orders
    @p=Purchase.select("DISTINCT(purchase_id)").where(user:current_user).pluck(:purchase_id).uniq
  end

  def all_orders
    if logged_in?(:owner)
      @p=nil
      User.all.each_with_index do |user,idx|
        if idx==0
          @p=Purchase.select("DISTINCT(purchase_id)").where(user:user).pluck(:purchase_id).uniq
        else
          @p<<Purchase.select("DISTINCT(purchase_id)").where(user:user).pluck(:purchase_id).uniq
        end
      end
      @p.flatten!
      #byebug
      render :orders
    else
      redirect_to root_path
    end
  end

  def bills
    @purchasess=Purchase.where(purchase_id:params[:id]).includes(:product)
  end
end
