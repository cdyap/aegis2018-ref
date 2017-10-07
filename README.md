# aegis2017

To add seed data:
1. Open seeds.rb
2. Type scripts
3. Run "rake db:seed"

Creating timeslots:
Date.new(2017, 10, 23).upto(Date.new(2017, 10, 28)) do |date|
	Timeslot.create!(start_time: "0800", end_time: "0900", date: date, slots:13,)
	Timeslot.create!(start_time: "0900", end_time: "1000", date: date, slots:13,)
	Timeslot.create!(start_time: "1000", end_time: "1100", date: date, slots:13,)
	Timeslot.create!(start_time: "1100", end_time: "1200", date: date, slots:13,)
	Timeslot.create!(start_time: "1200", end_time: "1300", date: date, slots:13,)
	Timeslot.create!(start_time: "1300", end_time: "1400", date: date, slots:13,)
	Timeslot.create!(start_time: "1400", end_time: "1500", date: date, slots:13,)
	Timeslot.create!(start_time: "1500", end_time: "1600", date: date, slots:13,)
	Timeslot.create!(start_time: "1600", end_time: "1700", date: date, slots:13,)
	Timeslot.create!(start_time: "1700", end_time: "1800", date: date, slots:13,)
end

Date.new(2017, 11, 2).upto(Date.new(2017, 11, 4)) do |date|
  Timeslot.create!(start_time: "0800", end_time: "0900", date: date, slots:13,)
	Timeslot.create!(start_time: "0900", end_time: "1000", date: date, slots:13,)
	Timeslot.create!(start_time: "1000", end_time: "1100", date: date, slots:13,)
	Timeslot.create!(start_time: "1100", end_time: "1200", date: date, slots:13,)
	Timeslot.create!(start_time: "1200", end_time: "1300", date: date, slots:13,)
	Timeslot.create!(start_time: "1300", end_time: "1400", date: date, slots:13,)
	Timeslot.create!(start_time: "1400", end_time: "1500", date: date, slots:13,)
	Timeslot.create!(start_time: "1500", end_time: "1600", date: date, slots:13,)
	Timeslot.create!(start_time: "1600", end_time: "1700", date: date, slots:13,)
	Timeslot.create!(start_time: "1700", end_time: "1800", date: date, slots:13,)
end

Date.new(2017, 11, 6).upto(Date.new(2017, 11, 11)) do |date|
  Timeslot.create!(start_time: "0800", end_time: "0900", date: date, slots:13,)
	Timeslot.create!(start_time: "0900", end_time: "1000", date: date, slots:13,)
	Timeslot.create!(start_time: "1000", end_time: "1100", date: date, slots:13,)
	Timeslot.create!(start_time: "1100", end_time: "1200", date: date, slots:13,)
	Timeslot.create!(start_time: "1200", end_time: "1300", date: date, slots:13,)
	Timeslot.create!(start_time: "1300", end_time: "1400", date: date, slots:13,)
	Timeslot.create!(start_time: "1400", end_time: "1500", date: date, slots:13,)
	Timeslot.create!(start_time: "1500", end_time: "1600", date: date, slots:13,)
	Timeslot.create!(start_time: "1600", end_time: "1700", date: date, slots:13,)
	Timeslot.create!(start_time: "1700", end_time: "1800", date: date, slots:13,)
end

Date.new(2017, 11, 13).upto(Date.new(2017, 11, 18)) do |date|
  Timeslot.create!(start_time: "0800", end_time: "0900", date: date, slots:13,)
	Timeslot.create!(start_time: "0900", end_time: "1000", date: date, slots:13,)
	Timeslot.create!(start_time: "1000", end_time: "1100", date: date, slots:13,)
	Timeslot.create!(start_time: "1100", end_time: "1200", date: date, slots:13,)
	Timeslot.create!(start_time: "1200", end_time: "1300", date: date, slots:13,)
	Timeslot.create!(start_time: "1300", end_time: "1400", date: date, slots:13,)
	Timeslot.create!(start_time: "1400", end_time: "1500", date: date, slots:13,)
	Timeslot.create!(start_time: "1500", end_time: "1600", date: date, slots:13,)
	Timeslot.create!(start_time: "1600", end_time: "1700", date: date, slots:13,)
	Timeslot.create!(start_time: "1700", end_time: "1800", date: date, slots:13,)
end

Date.new(2017, 11, 20).upto(Date.new(2017, 11, 23)) do |date|
  Timeslot.create!(start_time: "0800", end_time: "0900", date: date, slots:13,)
	Timeslot.create!(start_time: "0900", end_time: "1000", date: date, slots:13,)
	Timeslot.create!(start_time: "1000", end_time: "1100", date: date, slots:13,)
	Timeslot.create!(start_time: "1100", end_time: "1200", date: date, slots:13,)
	Timeslot.create!(start_time: "1200", end_time: "1300", date: date, slots:13,)
	Timeslot.create!(start_time: "1300", end_time: "1400", date: date, slots:13,)
	Timeslot.create!(start_time: "1400", end_time: "1500", date: date, slots:13,)
	Timeslot.create!(start_time: "1500", end_time: "1600", date: date, slots:13,)
	Timeslot.create!(start_time: "1600", end_time: "1700", date: date, slots:13,)
	Timeslot.create!(start_time: "1700", end_time: "1800", date: date, slots:13,)
end