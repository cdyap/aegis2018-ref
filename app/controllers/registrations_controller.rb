class RegistrationsController < Devise::RegistrationsController
	skip_before_filter :verify_authenticity_token, :only => :create
	# def new 
	# 	if Time.current.in_time_zone('Hong Kong').between?(Time.new(2016, 11, 3, 16).in_time_zone('Hong Kong'), Time.new(2016, 12, 10, 15).in_time_zone('Hong Kong'))
	# 		super
	# 	else 
	# 		redirect_to root_path
	# 	end
	# end

	def create
		super do
			@student = Student.find(resource.student_id)
			if resource.name == ""
				resource.name = @student.name
			end
			resource.yr = @student.yr
			resource.course = @student.course
			resource.school = @student.school

			resource.save(validate: false)
			@student.account = true
			@student.save
			# Student.find(params[:account][:student_id]).update(account: true)
		end

		# redirect_to root_path
	end

	

	protected

		def after_sign_up_path_for(resource)
	    # check for the class of the object to determine what type it is
		    if resource.class == Admin
		      admins_path
		    elsif resource.class == Account
		      accounts_path
		    end 
		end

	
	def update_resource(resource, params)
    	resource.update_without_password(params)
  	end

	  def sign_up_params
	    params.require(resource_name).permit(:student_id, :name, :yr, :course, :school, :email, :password, :password_confirmation, :id)
	  end

	  def account_update_params
	    params.require(resource_name).permit(:name, :yr, :course, :school, :email, :password, :password_confirmation)
	  end  
	  
	  def configure_permitted_parameters
	      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:student_id, :name, :yr, :course, :school, :email, :password, :password_confirmation, :id) }
	      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :remember_me) }
	  end
end
