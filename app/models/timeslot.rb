class Timeslot < ActiveRecord::Base
	has_many :accounts, before_add: :validate_user_limit, after_add: :subtract_slots

	def to_s
		self.date.strftime("%a, %b %d") + "; " + self.start_time + " - " + self.end_time
	end

	def start_time_to_s
		case self.start_time
		when "08:00"
			"8:00 AM"
		when "09:00"
			"9:00 AM"
		when "10:00"
			"10:00 AM"
		when "11:00"
			"11:00 AM"
		when "12:00"
			"12:00 PM"
		when "13:00"
			"1:00 PM"
		when "14:00"
			"2:00 PM"
		when "15:00"
			"3:00 PM"
		when "16:00"
			"4:00 PM"
		when "17:00"
			"5:00 PM"
		end
	end

	def end_time_to_s
		case self.end_time
		when "18:00"
			"6:00 PM"
		when "09:00"
			"9:00 AM"
		when "10:00"
			"10:00 AM"
		when "11:00"
			"11:00 AM"
		when "12:00"
			"12:00 PM"
		when "13:00"
			"1:00 PM"
		when "14:00"
			"2:00 PM"
		when "15:00"
			"3:00 PM"
		when "16:00"
			"4:00 PM"
		when "17:00"
			"5:00 PM"
		end
	end
	private

	def validate_user_limit(account)
	    raise Exception.new if accounts.size >= self.slots
	end

	def subtract_slots(account)
		self.slots = self.slots - 1
	end
  
	  def self.to_csv(options = {})
	    (CSV.generate(options) do |csv|
	      column_names = %w(date start_time end_time slots accounts)
	      # names = column_names << "students"
	      csv << column_names
	      all.each do |timeslot|
	      	timeslot_accounts = ""
	      	timeslot.accounts.each do |account|
	      		timeslot_accounts += account.to_s + "\n"
	      	end
	        row_values = timeslot.attributes.values_at(*column_names).insert(-1, timeslot_accounts)
	        csv << row_values
	      end
	    end).encode('WINDOWS-1252', :undef => :replace, :replace => '')
	  end
end
