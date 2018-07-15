module DeviseWhitelist
	extend ActiveSupport::Concern
	included do 
		before_action :configure_params, if: :devise_controller?
	end
	
	def configure_params
	  	devise_parameter_sanitizer.permit(:sign_up,keys:[:name])
	  	devise_parameter_sanitizer.permit(:account_update,keys:[:name])

	  	devise_parameter_sanitizer.permit(:sign_up,keys:[:roles])
	  	devise_parameter_sanitizer.permit(:account_update,keys:[:roles])
	  	
	  	devise_parameter_sanitizer.permit(:sign_up,keys:[:address])
	  	devise_parameter_sanitizer.permit(:account_update,keys:[:address])
	  	
	  	devise_parameter_sanitizer.permit(:sign_up,keys:[:city])
	  	devise_parameter_sanitizer.permit(:account_update,keys:[:city])
	  	
	  	devise_parameter_sanitizer.permit(:sign_up,keys:[:pincode])
	  	devise_parameter_sanitizer.permit(:account_update,keys:[:pincode])
	  	
	  	devise_parameter_sanitizer.permit(:sign_up,keys:[:country])
	  	devise_parameter_sanitizer.permit(:account_update,keys:[:country])

	end
end