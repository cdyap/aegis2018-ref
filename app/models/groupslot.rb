class Groupslot < ActiveRecord::Base
	validates :groupshot_id, presence: true
	validates :student_id, presence: true
	validates :group_name, presence: true

	def to_s
		groupshot = Groupshot.find_by(id: self.groupshot_id)
		self.group_name + ": " + groupshot.date.strftime("%a, %b %d") + "; " + groupshot.start_time + " - " + groupshot.end_time
	end
end
