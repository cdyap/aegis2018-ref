class Groupslot < ActiveRecord::Base
	validates :groupshot_id, presence: true
	validates :student_id, presence: true
	validates :group_name, presence: true

	def to_s
		groupshot = Groupshot.find_by(id: self.groupshot_id)
		self.group_name + ": " + groupshot.date.strftime("%a, %b %d") + "; " + groupshot.start_time + " - " + groupshot.end_time
	end

	def point_person
		@account = Account.find_by(student_id: self.student_id)

		if !@account.nil?
			return @account.student_id.to_s + " - " + @account.name + ", " + @account.yr.to_s + "-" + @account.course
		else
			return ""
		end
	end
end
