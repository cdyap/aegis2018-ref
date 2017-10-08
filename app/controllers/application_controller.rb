class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  	protect_from_forgery with: :exception

  	def after_sign_in_path_for(resource)
  	  	# raise resource.inspect
	    # check for the class of the object to determine what type it is
	    if resource.class == Admin
	      admins_path
	    elsif resource.class == Account
	      accounts_path
	    end 
	end

  	protected
	  	def authenticate_user!
	    	if !account_signed_in?
	      		redirect_to new_account_session_path
	      	end
	  	end
end
