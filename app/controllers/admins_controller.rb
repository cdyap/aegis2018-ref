# encoding: utf-8
class AdminsController < ApplicationController
	before_filter :authenticate_admin!
	skip_before_action :verify_authenticity_token
	layout :resolve_layout

	def new
		redirect_to root_path
	end

	def create
		redirect_to root_path
	end

	def clean_timeslots
		Timeslot.where(type: nil).each do |timeslot|
			@accounts = Account.where(timeslot_id: timeslot.id).count

			if @accounts != (14 - timeslot.slots)
				timeslot.slots = 14 - @accounts
				timeslot.save
			end
		end

		Groupshot.all.each do |groupshot|
			@accounts = Groupslot.where(groupshot_id: groupshot.id).count

			if @accounts != (18 - groupshot.slots)
				groupshot.slots = 18 - @accounts
				groupshot.save
			end
		end

		# Timeslot.where(date: "2016-10-22").where(start_time: "11:00 AM").update_all(slots: 0)
		# Timeslot.where(date: "2016-11-04").where(start_time: "10:00 AM").update_all(slots: 0)
		Timeslot.where(date: "2016-10-17").where(start_time: "08:00 AM").update_all(slots: 0)
		flash[:notice] = "Timeslot counts cleaned."
		redirect_to :back	
	end	

	def index
		@soh_writeups = Account.where(school: "SOH").where(final_writeup: true).count
		@som_writeups = Account.where(school: "SOM").where(final_writeup: true).count
		@sose_writeups = Account.where(school: "SOSE").where(final_writeup: true).count
		@soss_writeups = Account.where(school: "SOSS").where(final_writeup: true).count
		@total_writeups = @soh_writeups + @som_writeups + @sose_writeups + @soss_writeups

		@soh_students = Student.where(school: "SOH").count
		@som_students = Student.where(school: "SOM").count
		@sose_students = Student.where(school: "SOSE").count
		@soss_students = Student.where(school: "SOSS").count
		@students = @soh_students + @som_students + @sose_students + @soss_students

		@soh_accounts = Account.where(school: "SOH").count
		@som_accounts = Account.where(school: "SOM").count
		@sose_accounts = Account.where(school: "SOSE").count
		@soss_accounts = Account.where(school: "SOSS").count
		@accounts = @soh_accounts + @som_accounts + @sose_accounts + @soss_accounts
		
		@true_accounts = Student.where(account:true).count
		@error_accounts = Account.where(name: "")

		@a = Student.where(account: true).where.not(id: Account.select("student_id"))
		@b = Account.where.not(student_id: Student.select(:id).where(account:true))


		@soh_shoots = Account.where(school: "SOH").where.not(timeslot_id: nil).count
		@soss_shoots = Account.where(school: "SOSS").where.not(timeslot_id: nil).count
		@sose_shoots = Account.where(school: "SOSE").where.not(timeslot_id: nil).count
		@som_shoots = Account.where(school: "SOM").where.not(timeslot_id: nil).count

		@soh_feedback = Account.where(school: "SOH").where.not(feedback: nil).count
		@som_feedback = Account.where(school: "SOM").where.not(feedback: nil).count
		@soss_feedback = Account.where(school: "SOSS").where.not(feedback: nil).count
		@sose_feedback = Account.where(school: "SOSE").where.not(feedback: nil).count
		@total_feedback = Account.where.not(feedback: nil).count

		@soh_conforme = Account.where(school: "SOH").where.not(conforme: nil).count
		@som_conforme = Account.where(school: "SOM").where.not(conforme: nil).count
		@soss_conforme = Account.where(school: "SOSS").where.not(conforme: nil).count
		@sose_conforme = Account.where(school: "SOSE").where.not(conforme: nil).count
		@total_conforme = Account.where.not(conforme: nil).count

		@soh_signed = Account.where(school: "SOH").where(yearbook_waiver: true).count
		@som_signed = Account.where(school: "SOM").where(yearbook_waiver: true).count
		@soss_signed = Account.where(school: "SOSS").where(yearbook_waiver: true).count
		@sose_signed = Account.where(school: "SOSE").where(yearbook_waiver: true).count
		@total_signed = Account.where(yearbook_waiver: true).count

		@total_shoots = Account.where.not(timeslot_id: nil).count

		@accounts_list = Account.order(:student_id)

		@total_groupshots = Groupslot.all.count

	    respond_to do |format|
	      format.html
	      format.csv { send_data @accounts_list.to_csv,  filename: "accounts-#{Date.today}.csv" }
	      format.xls
	    end

	end

	def students
		@students = Student.all.order('id ASC').paginate(:page => params[:page], :per_page => 60)
	end

	def accounts
		@accounts = Account.order('student_id ASC').paginate(:page => params[:page], :per_page => 200)

		@account_number = Account.count
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

		@timeslots = Timeslot.order(:date, :start_time)

		respond_to do |format|
	      format.html
	      format.csv { send_data @timeslots.to_csv,  filename: "signups-#{Date.today}.csv" }
	    end
	end


	def edit_account
		if request.post?
			@account = Account.find(params[:account][:id])

			@account.update_column(:student_id, params[:account][:student_id])
			@account.update_column(:email, params[:account][:email])
			
			flash[:success] = "Account details edited!"

			redirect_to accounts_admins_path, method: :get
		else
			@account = Account.find_by(student_id: params[:student_id])
			if !@account.nil? 
				@account
			else
				flash[:notice] = "Student not found."
				redirect_to :back
			end
		end

		
	end

	def reset_password
		@student = Account.find_by(student_id: params[:id])
		if @student.present?
			@student.password = "Password1234"
			@student.password_confirmation = "Password1234"
			@student.save
			flash[:notice] = "Student #{params[:id]} password resetted to 'Password1234'."
			redirect_to :back
		else
			flash[:notice] = "Student #{params[:id]} not found."
			redirect_to :back
		end
	end

	private

	  def resolve_layout 
	  	case action_name 
	  	when "index", "sign_ups"
	  		"admins"
	  	end
	  end
end
