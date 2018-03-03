class AccountsController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_filter :check_for_cancel, :only => [:add_writeup, :edit_info]
	before_filter :authenticate_user!, :except => [:search, :reset_writeup, :reset_feedback, :add_writeup, :submit_final_writeup ]
	layout :resolve_layout

	def index
		@school = current_account.school
		@events = Event.where(description: ["All", @school]).order(:start_time)
		@timeslot = Timeslot.find_by(id: current_account.timeslot_id)
		
		@groupslot = Groupslot.find_by(student_id: current_account.student_id)
		
		if @groupslot.present?
			@groupshot = Groupshot.find_by(id: @groupslot.groupshot_id)
		end
	end	

	def group_signups
		# if current_account.can_signup_for_group
			@checkgroupslot = Groupslot.where(student_id: current_account.student_id)
			if @checkgroupslot.count > 0
				@has_groupshot = true
				@checkgroupslot = @checkgroupslot.first
				@timeslot = Groupshot.find(@checkgroupslot.groupshot_id)
			end
			@slots = Groupshot.all.order(:date).order(:start_time)
			@dates = ["2017-11-17","2017-11-18","2017-11-20","2017-11-21","2017-11-22","2017-11-23"]
		# else
		# 	redirect_to accounts_path, method: :get
		# end
	end

	def sign_ups
		if current_account.timeslot_id.present? 
			@timeslot = Timeslot.find(current_account.timeslot_id)
		end

		@dates = []

		case current_account.school
		when "SOH"
			@dates = ["2017-10-23", "2017-10-24", "2017-10-25"]
			@slots = Timeslot.where(date: @dates).order(:start_time)
		when "SOSS"
			@dates = ["2017-10-26", "2017-10-27", "2017-10-28", "2017-10-30", "2017-11-02", "2017-11-03"]
			@slots = Timeslot.where(date: @dates).order(:start_time)
		when "SOSE"
			@dates = ["2017-11-04", "2017-11-06", "2017-11-07", "2017-11-08", "2017-11-09"]
			@slots = Timeslot.where(date: @dates).order(:start_time)
		when "SOM"
			@dates = ["2017-11-10", "2017-11-11", "2017-11-13", "2017-11-14", "2017-11-15", "2017-11-16"]
			@slots = Timeslot.where(date: @dates).order(:start_time)
		end

	end

	def search 
		idparams = params[:id]
		@student=Account.find_by(student_id: idparams)

		if @student.timeslot_id.nil?
			@timeslot = "No timeslot."
		else
			@timeslot = Timeslot.find(@student.timeslot_id).to_s
		end

		respond_to do |format|
			format.html
			format.json {render json: @student, methods: :get_timeslot}
		end
	end

	def destroy 
		@account = Account.find(params[:id])
		@student = Student.find(@account.student_id)
		@student.update_attribute(:account, false)

	    @account.destroy

	    if @account.destroy
	        redirect_to accounts_admins_path, notice: "Account #{@account.student_id} deleted."
	    end
	end

	def reschedule
		if current_account.can_signup
			@timeslot = Timeslot.find_by(id: current_account.timeslot_id)
			@timeslot.slots = @timeslot.slots + 1
			@timeslot.save

			current_account.timeslot_id = nil
			current_account.rescheduled = true
			current_account.save(validate: false)

			flash[:alert] = "Timeslot reset."
			redirect_to sign_ups_accounts_path
		else
			flash[:alert] = "You may not reschedule your timeslot."
			redirect_to :back
		end
	end

	def reschedule_group
		if current_account.can_signup_for_group
			groupslot = Groupslot.find_by(id: current_account.groupshot_id)
			groupshot = Groupshot.find_by(id: groupslot.groupshot_id)
			groupslot.delete
			
			groupshot.slots = groupshot.slots + 1
			groupshot.save

			current_account.groupshot_id = nil
			current_account.save(validate: false)

			flash[:alert] = "Groupshot reset."
			redirect_to group_signups_accounts_path
		else
			flash[:alert] = "You may not reschedule your group photoshoot."
			redirect_to :back
		end
	end

	def sign_up
		if current_account.can_signup
			@timeslot = Timeslot.find(params[:slot_id])

			if @timeslot.slots > 0
				
				@timeslot.slots = @timeslot.slots - 1
				if @timeslot.slots < 0
					flash[:alert] = "Slot already taken."
					redirect_to sign_ups_accounts_path
				else
					@timeslot.save
					current_account.timeslot_id = params[:slot_id]
					current_account.save(validate: false)
				end

				redirect_to sign_ups_accounts_path
			elsif @timeslot.slots == 0
				flash[:alert] = "Slot already taken."
				redirect_to sign_ups_accounts_path
			end
		else
			flash[:alert] = "You may not sign up."
			redirect_to :back
		end
	end

	def group_signup

		if current_account.can_signup_for_group
			@timeslot = Groupshot.find(params[:slot_id])

			if params[:group_name] != "" or params[:group_name].present?
				if params[:group_type].present?
					if @timeslot.slots > 0 
						@timeslot.slots = @timeslot.slots - 1
						
						if @timeslot.slots < 0
							flash[:alert] = "Slot already taken."
							redirect_to group_signups_accounts_path
						else
							@timeslot.save
							@groupslot = Groupslot.new
							@groupslot.student_id = current_account.student_id
							@groupslot.groupshot_id = params[:slot_id]
							@groupslot.group_name = params[:group_name]
							@groupslot.group_type = params[:group_type]
							@groupslot.save
							current_account.update(groupshot_id: @groupslot.id)
							redirect_to group_signups_accounts_path
						end
					elsif @timeslot.slots == 0
						flash[:alert] = "Slot already taken."
						redirect_to group_signups_accounts_path
					end
				else
					flash[:alert] = "Please select the type of organization."
					redirect_to group_signups_accounts_path
				end
			else
				flash[:alert] = "Please enter a group name."
				redirect_to group_signups_accounts_path
			end
		else
			flash[:alert] = "You may not sign up."
			redirect_to :back
		end

		
		
	end

	def photoshoot
		@account = Account.where(student_id: params[:id]).first
		if @account.timeslot_id.present?
			@timeslot = Timeslot.find(@account.timeslot_id)
			@timeslot.slots = @timeslot.slots + 1
			@timeslot.save

			@account.timeslot_id = nil
			@account.save(validate: false)

			flash[:notice] = "Account #{@account.student_id} timeslot reset."
			redirect_to :back
		end
	end

	def slip
		@timeslot = Timeslot.find(current_account.timeslot_id)
		respond_to do |format|
	      format.html
	      format.pdf do
	        render pdf: "confirmation_slip",
	          layout: 'pdf.html.erb',
	          debug: true,
	          template: 'accounts/slip.pdf.erb',
	          show_as_html: params[:debug].present?,
	          margin:  {   top:               10,                     # default 10 (mm)
	                    bottom:            10,
	                    left:              10,
	                    right:             10 }
	      end
	    end
	end

	def groupslip
		@groupslot = Groupslot.where(student_id: current_account.student_id).first
		@timeslot = Groupshot.find(@groupslot.groupshot_id)


		respond_to do |format|
	      format.html
	      format.pdf do
	        render pdf: "group_confirmation_slip",
	          layout: 'pdf.html.erb',
	          debug: true,
	          template: 'accounts/groupslip.pdf.erb',
	          show_as_html: params[:debug].present?,
	          margin:  {   top:               10,                     # default 10 (mm)
	                    bottom:            10,
	                    left:              10,
	                    right:             10 }
	      end
	    end
	end

	def check_for_cancel
	  if params[:commit] == "Cancel"
	    redirect_to view_writeup_accounts_path
	  end
	end

	def timeslots
		@dates = []
		@dates_g = []
		Timeslot.where(type: nil).distinct(:date).order(:date).pluck(:date).each do |timeslot|
			instance_variable_set "@slots_#{timeslot.to_s.underscore}".to_sym, Timeslot.where(date: timeslot)
			@dates << "#{timeslot.to_s.underscore}"
		end

		Groupshot.distinct(:date).order(:date).pluck(:date).each do |timeslot|
			instance_variable_set "@slots_#{timeslot.to_s.underscore}".to_sym, Timeslot.where(date: timeslot)
			@dates_g << "#{timeslot.to_s.underscore}"
		end
	end

	def view_writeup
		@account = current_account
		#if !current_account.can_write
			#redirect_to accounts_path
		#end
	end

	def add_writeup
		@account = current_account

		if !@account.can_submit_writeup
			redirect_to accounts_path
		end
	end

	def admin_writeup
		@student = Account.find_by(student_id: params[:id])

		if @student.present? 
			if @student.writeup.present?
				flash[:notice] = "Student #{params[:id]} has a write-up."
				redirect_to :back
			else
				@student.update_attributes(writeup: params[:writeup])
				@student.update_attributes(final_writeup: true)
				flash[:notice] = "Student #{params[:id]} write-up added."
				redirect_to :back
			end
		else
			flash[:notice] = "Student #{params[:id]} not found."
			redirect_to :back
		end
	end

	def submit_writeup

	end

	def submit_final_writeup 
		current_account.update(final_writeup:  true)
		redirect_to edit_info_accounts_path
	end

	def edit_info
		@account = current_account

		@soh_minors = ["Literature (English)", "Literature (Filipino)", "Creative Writing", "Theater Arts", "Music Literature", "French", "German", "Spanish", "Philosophy"].sort_by!{ |e| e.downcase }

		@som_minors = ["Financial Management", "International Business", "Strategic Human Resource Management", "Management", "Sustainability", "Marketing", "Information Technology", "Decision Science", "Project Management", "Enterprise Development"].sort_by!{ |e| e.downcase }

		@soh_certificates = ["Certificate Program - Creative Writing", "Certificate Program - Theater Arts", "Certificate Program - Spanish"].sort_by!{ |e| e.downcase }

		@sose_minors = ["Biomedical Science","Ecology and Systematics",	"Microbiology",	"Molecular Biology and Biotechnology",	"Minor in Enterprise Systems",	"Minor in Data Science and Analytics",	"Minor in Interactive Multimedia",	"Specialization in Enterprise Systems",	"Specialization in Data Science and Analytics",	"Specialization in Interactive Multimedia"].sort_by!{ |e| e.downcase }

		@soss_minors = ["Chinese Studies", "Development Management", "Health and Development", "Economics", "Education", "European Studies", "History", "Japanese Studies", "Korean Studies", "Global Politics", "Public Management", "Cultural Heritage", "Sociology", "Humanitarian Action"].sort_by!{ |e| e.downcase }

		@soss_specializations = ["Specialization in Development Management", "Specialization in Health and Development", "Specialization in Cultural Heritage"].sort_by!{ |e| e.downcase }

		@soss_certificates = ["Certificate Program - Chinese Language Proficiency", "Certificate Program - Completion of Chinese Language Subjects"].sort_by!{ |e| e.downcase }

		@soh_majors = ["BFA Art Management","BFA Creative Writing","BFA Information Design","BFA Theater Arts","AB	Humanities","AB	Interdisciplinary Studies","AB	Literature - English", "AB	Literature - Filipino (Filipino-Panitikan)","AB	Philosophy"].sort_by!{ |e| e.downcase }

		@soss_majors = ["AB Chinese Studies","AB Communication","AB Development Studies","AB Diplomacy and International Relations with Specialization in East and Southeast Asian Studies", "AB Economics", "AB Economics (Honors)","AB European Studies","AB History","AB Management Economics","AB Political Science","AB/MA Political Science - Major in Global Politics","AB Political Science - Masters in Public Management","AB Psychology","BS Psychology","AB Social Sciences"].sort_by!{ |e| e.downcase }

		@sose_majors = ["BS Applied Physics - BS Materials Science and Engineering","BS Biology","BS Chemistry - BS Materials Science and Engineering","BS Chemistry","BS Computer Science","BS/MS Computer Science","BS Computer Engineering","BS Computer Science - BS Digital Game Design and Development", "BS Environmental Science","BS Electronics Engineering","BS Health Sciences","BS Life Sciences","BS Management Information Systems - MS Computer Science","BS Management Information Systems","BS/M Applied Mathematics with Specialization in Mathematical Finance","BS Mathematics","BS Physics"].sort_by!{ |e| e.downcase }

		@som_majors = ["BS Communications Technology Management","BS Information Technology Entrepreneurship","BS Legal Management","BS Management","BS Management (Honors)","BS Management Engineering","BS Management of Applied Chemistry"].sort_by!{ |e| e.downcase }
	end

	def reset_writeup 
		@student = Account.find_by(student_id: params[:id])

		if @student.present? 
			@student.update_attributes(final_writeup: false)
			flash[:notice] = "Student #{params[:id]} write-up set to temporary status."
			redirect_to :back
		else
			flash[:notice] = "Student #{params[:id]} not found."
			redirect_to :back
		end
	end

	def reset_timeslot
		@student = Account.find_by(student_id: params[:id])
		if @student.present? && !@student.timeslot_id.nil? 
			@timeslot = Timeslot.find(@student.timeslot_id)
			@slots = @timeslot.slots
			@timeslot.update(slots: @slots + 1)
			@student.update_attributes(timeslot_id: nil)
			flash[:notice] = "Student #{params[:id]} removed from timeslot."
			redirect_to :back
		elsif @student.present? && @student.timeslot_id.nil?
			flash[:notice] = "Account #{params[:id]} has no timeslot yet."
			redirect_to :back
		else
			flash[:notice] = "Account #{params[:id]} not found."
			redirect_to :back
		end
	end

	def reset_feedback
		@student = Account.find_by(student_id: params[:id])

		if @student.present?
			@student.update_columns(feedback: nil, conforme: nil, yearbook_waiver: false)
			# @student.feedback = nil
			# @student.conforme = nil
			# @student.yearbook_waiver = false
			# @student.save 
			flash[:notice] = "Student #{params[:id]} waiver, feedback, and conforme resetted."
			redirect_to :back
		else
			flash[:notice] = "Student #{params[:id]} not found."
			redirect_to :back
		end
	end

	def yearbook_preview
		@casualshot = current_account.yearbook_shot
		@togashots = current_account.toga_shots
	end

	def addfeedback

		feedback = "["+params[:page_number]+"]"+"["+params[:name]+"]"+"["+params[:feedback]+"]"
		current_account.update_column(:feedback, feedback)

		flash[:success] = "Feedback submitted!"
		redirect_to :back
	end

	def addconforme
		if params[:conforme] == ""
			flash[:error] = "Electronic signature required!"
			redirect_to :back
		end
		current_account.conforme = params[:conforme]
		current_account.save

		flash[:success] = "Yearbook pages accepted!"
		redirect_to :back
	end

	def accept_yearbook_waiver
		current_account.yearbook_waiver = true
		current_account.save

		redirect_to yearbook_preview_accounts_path
	end

	def update		
		if params[:writeup_submit]
			@account = current_account
			@account.update_attributes!(account_params)
			flash[:success] = "Write-up draft saved!"
			redirect_to :back
		elsif params[:account_submit]
			@account = current_account
			@account.final_writeup = true
			@account.save
			@account.update_attributes!(account_params)
			flash[:success] = "Final write-up submitted!"
			redirect_to :back
		elsif params[:edit_account]
			if params[:account][:email] != current_account.email
				if current_account.update_attributes(account_params)
					flash[:success] = "Information successfully edited!"
					redirect_to :back
				else
					@errors = current_account.errors.full_messages
					flash[:error] = @errors
					@account = current_account
					redirect_to :back
				end
			else
				params[:account].except(:email)
				if current_account.update_attributes(account_params.except(:email))
					current_account.save!
					flash[:success] = "Information successfully edited!"
					redirect_to :back
				else
					@errors = current_account.errors.full_messages
					flash[:error] = @errors
					@account = current_account
					redirect_to :back
				end
			end

		else
			redirect_to accounts_path
		end

		# current_account.update_attribute(:feedback, params[:feedback])
		# flash[:success] = "Feedback submitted!"
		# redirect_to accounts_path
	end

	def update_password
		@account = current_account
	    if @account.update(account_params)
	      # Sign in the user by passing validation in case their password changed
	      bypass_sign_in @account, scope: :account
	      redirect_to root_path
	    else
	      render "edit"
	    end
	end

	def account_params
	  params.require(:account).permit(:writeup, :double_major, :minor, :cellphone_number, :full_course, :second_status, :email, :feedback)
	end

	private

	  def process(action, *args)
	    super
	  	rescue AbstractController::ActionNotFound
	    respond_to do |format|
	      format.html { render file: "#{Rails.root}/public/404.html" , status: 404}
	      format.all { render nothing: true, status: :not_found }
	    end
	  end

	  def resolve_layout 
	  	case action_name 
	  	when "index", "sign_ups", "yearbook_preview"
	  		"accounts"
	  	end
	  end

	  def account_params
	  	 params.require(:account).permit(:password, :password_confirmation, :writeup, :minor, :description, :double_major, :cellphone_number, :email, :minor2, :minor3, :minor4, :triple_major)
	  end
end
