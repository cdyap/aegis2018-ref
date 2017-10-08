# aegis2017

To add seed data:
1. Open seeds.rb
2. Type scripts
3. Run "rake db:seed"

Adding admins:
Admin.create!([{email: "{email}", password: "{plain text password}"}])

Creating timeslots:
Note: start_time format "08:00"
Date.new(2017, 10, 23).upto(Date.new(2017, 10, 28)) do |date|
	Timeslot.create!(start_time: "08:00", end_time: "09:00", date: date, slots:13,)
	Timeslot.create!(start_time: "09:00", end_time: "10:00", date: date, slots:13,)
	Timeslot.create!(start_time: "10:00", end_time: "11:00", date: date, slots:13,)
	Timeslot.create!(start_time: "11:00", end_time: "12:00", date: date, slots:13,)
	Timeslot.create!(start_time: "12:00", end_time: "13:00", date: date, slots:13,)
	Timeslot.create!(start_time: "13:00", end_time: "14:00", date: date, slots:13,)
	Timeslot.create!(start_time: "14:00", end_time: "15:00", date: date, slots:13,)
	Timeslot.create!(start_time: "15:00", end_time: "16:00", date: date, slots:13,)
	Timeslot.create!(start_time: "16:00", end_time: "17:00", date: date, slots:13,)
	Timeslot.create!(start_time: "17:00", end_time: "18:00", date: date, slots:13,)
end

Date.new(2017, 11, 2).upto(Date.new(2017, 11, 4)) do |date|
  Timeslot.create!(start_time: "0800", end_time: "0900", date: date, slots:13,)
	Timeslot.create!(start_time: "09:00", end_time: "10:00", date: date, slots:13,)
	Timeslot.create!(start_time: "10:00", end_time: "11:00", date: date, slots:13,)
	Timeslot.create!(start_time: "11:00", end_time: "12:00", date: date, slots:13,)
	Timeslot.create!(start_time: "12:00", end_time: "13:00", date: date, slots:13,)
	Timeslot.create!(start_time: "13:00", end_time: "14:00", date: date, slots:13,)
	Timeslot.create!(start_time: "14:00", end_time: "15:00", date: date, slots:13,)
	Timeslot.create!(start_time: "15:00", end_time: "16:00", date: date, slots:13,)
	Timeslot.create!(start_time: "16:00", end_time: "17:00", date: date, slots:13,)
	Timeslot.create!(start_time: "17:00", end_time: "18:00", date: date, slots:13,)
end

Date.new(2017, 11, 6).upto(Date.new(2017, 11, 11)) do |date|
  Timeslot.create!(start_time: "0800", end_time: "0900", date: date, slots:13,)
	Timeslot.create!(start_time: "09:00", end_time: "10:00", date: date, slots:13,)
	Timeslot.create!(start_time: "10:00", end_time: "11:00", date: date, slots:13,)
	Timeslot.create!(start_time: "11:00", end_time: "12:00", date: date, slots:13,)
	Timeslot.create!(start_time: "12:00", end_time: "13:00", date: date, slots:13,)
	Timeslot.create!(start_time: "13:00", end_time: "14:00", date: date, slots:13,)
	Timeslot.create!(start_time: "14:00", end_time: "15:00", date: date, slots:13,)
	Timeslot.create!(start_time: "15:00", end_time: "16:00", date: date, slots:13,)
	Timeslot.create!(start_time: "16:00", end_time: "17:00", date: date, slots:13,)
	Timeslot.create!(start_time: "17:00", end_time: "18:00", date: date, slots:13,)
end

Date.new(2017, 11, 13).upto(Date.new(2017, 11, 18)) do |date|
  Timeslot.create!(start_time: "0800", end_time: "0900", date: date, slots:13,)
	Timeslot.create!(start_time: "09:00", end_time: "10:00", date: date, slots:13,)
	Timeslot.create!(start_time: "10:00", end_time: "11:00", date: date, slots:13,)
	Timeslot.create!(start_time: "11:00", end_time: "12:00", date: date, slots:13,)
	Timeslot.create!(start_time: "12:00", end_time: "13:00", date: date, slots:13,)
	Timeslot.create!(start_time: "13:00", end_time: "14:00", date: date, slots:13,)
	Timeslot.create!(start_time: "14:00", end_time: "15:00", date: date, slots:13,)
	Timeslot.create!(start_time: "15:00", end_time: "16:00", date: date, slots:13,)
	Timeslot.create!(start_time: "16:00", end_time: "17:00", date: date, slots:13,)
	Timeslot.create!(start_time: "17:00", end_time: "18:00", date: date, slots:13,)
end

Date.new(2017, 11, 20).upto(Date.new(2017, 11, 23)) do |date|
  Timeslot.create!(start_time: "0800", end_time: "0900", date: date, slots:13,)
	Timeslot.create!(start_time: "09:00", end_time: "10:00", date: date, slots:13,)
	Timeslot.create!(start_time: "10:00", end_time: "11:00", date: date, slots:13,)
	Timeslot.create!(start_time: "11:00", end_time: "12:00", date: date, slots:13,)
	Timeslot.create!(start_time: "12:00", end_time: "13:00", date: date, slots:13,)
	Timeslot.create!(start_time: "13:00", end_time: "14:00", date: date, slots:13,)
	Timeslot.create!(start_time: "14:00", end_time: "15:00", date: date, slots:13,)
	Timeslot.create!(start_time: "15:00", end_time: "16:00", date: date, slots:13,)
	Timeslot.create!(start_time: "16:00", end_time: "17:00", date: date, slots:13,)
	Timeslot.create!(start_time: "17:00", end_time: "18:00", date: date, slots:13,)
end