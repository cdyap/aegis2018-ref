class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:student_id]
  belongs_to :timeslot
  belongs_to :groupshot
  # validates_uniqueness_of :email, :student_id
  validates :writeup, length: { maximum: 505 }
  validates :cellphone_number, :numericality => true, :allow_blank => true
  
  def to_s
    "#{self.student_id}, #{self.name}, #{self.yr} - #{self.course}"
  end

  def can_write
    if WriteupAccount.find_by(idnumber: self.student_id).nil?
      return false
    else
      return true
    end
  end

  def yearbook_shot
    @casualshot = Student.find(self.student_id).page_number
    case @casualshot.to_s.length
    when 2
      return "/pics/00"+@casualshot.to_s+".pdf"
    when 3
      return "/pics/0"+@casualshot.to_s+".pdf"
    when 4
      return "/pics/"+@casualshot.to_s+".pdf"
    end

  end

  def get_timeslot
    Timeslot.find_by(id: self.timeslot_id).to_s
  end

  def active_for_authentication?
    super and self.can_login
  end

  def inactive_message
    # @SOHstart = Time.new(2016, 10, 2,23).in_time_zone('Hong Kong')
    # @SOHend = Time.new(2016, 10, 3, 15).in_time_zone('Hong Kong')

    # @SOSSstart = Time.new(2016, 10, 3, 23).in_time_zone('Hong Kong')
    # @SOSSend = Time.new(2016, 10, 4, 15).in_time_zone('Hong Kong')

    # @SOSEstart = Time.new(2016, 10, 4, 23).in_time_zone('Hong Kong')
    # @SOSEend = Time.new(2016, 10, 5, 15).in_time_zone('Hong Kong')

    # @SOMstart = Time.new(2016, 10, 5, 23).in_time_zone('Hong Kong')
    # @SOMend = Time.new(2016, 10, 6, 15).in_time_zone('Hong Kong')

    # @groupstart1 = Time.new(2016, 10, 6, 23).in_time_zone('Hong Kong')
    # @groupend1 = Time.new(2016, 10, 7, 15).in_time_zone('Hong Kong')

    # @groupstart2 = Time.new(2016, 10, 7, 23).in_time_zone('Hong Kong')
    # @groupend2 = Time.new(2016, 10, 8, 15).in_time_zone('Hong Kong')

    # @somspecialstart = Time.new(2016, 10, 8, 23).in_time_zone('Hong Kong')
    # @somspecialend = Time.new(2016, 10, 9, 15).in_time_zone('Hong Kong')

    # case self.school
    # when "SOH" 
    #     return "You may only login between " + @SOHstart.strftime("%b %d, %I:%M") + " AM and " + @SOHend.strftime("%b %d, %I:%M")  +" PM. "
    # when "SOSS"
    #     return "You may only login between " + @SOSSstart.strftime("%b %d, %I:%M")  + " AM and " + @SOSSend.strftime("%b %d, %I:%M")   +" PM. "
    # when "SOSE"
    #   return "You may only login between " + @SOSEstart.strftime("%b %d, %I:%M")  + " AM and " + @SOSEend.strftime("%b %d, %I:%M")   +" PM. "
    # when "SOM"
    #   return "You may only login between " + @SOMstart.strftime("%b %d, %I:%M")  + " AM and " + @SOMend.strftime("%b %d, %I:%M") +" PM. "
    # end

    return "Sign ups are from October 16 - 21."
  end

  def can_login
    return false
    # @end = Time.new(2017,3,1,0)
    # if Time.now >= @end
    #   return true
    # else
    #   return false
    # end
    # @SOHstart = Time.new(2016, 10, 2,23).in_time_zone('Hong Kong')
    # @SOHend = Time.new(2016, 10, 3, 15).in_time_zone('Hong Kong')

    # @SOSSstart = Time.new(2016, 10, 3, 23).in_time_zone('Hong Kong')
    # @SOSSend = Time.new(2016, 10, 4, 15).in_time_zone('Hong Kong')

    # @SOSEstart = Time.new(2016, 10, 4, 23).in_time_zone('Hong Kong')
    # @SOSEend = Time.new(2016, 10, 5, 15).in_time_zone('Hong Kong')

    # @SOMstart = Time.new(2016, 10, 5, 23).in_time_zone('Hong Kong')
    # @SOMend = Time.new(2016, 10, 6, 15).in_time_zone('Hong Kong')

    # @groupstart1 = Time.new(2016, 10, 6, 23).in_time_zone('Hong Kong')
    # @groupend1 = Time.new(2016, 10, 7, 15).in_time_zone('Hong Kong')

    # @groupstart2 = Time.new(2016, 10, 7, 23).in_time_zone('Hong Kong')
    # @groupend2 = Time.new(2016, 10, 8, 15).in_time_zone('Hong Kong')

    # @somspecialstart = Time.new(2016, 10, 8, 23).in_time_zone('Hong Kong')
    # @somspecialend = Time.new(2016, 10, 9, 15).in_time_zone('Hong Kong')

    # @specialstart = Time.new(2016, 10, 9, 16).in_time_zone('Hong Kong')
    # @specialend = Time.new(2016, 10, 13, 15).in_time_zone('Hong Kong')


    # case self.school
    # when "SOH" 
    #   if Time.current.in_time_zone('Hong Kong').between?(@SOHstart, @SOHend)
    #     return true
    #   else
    #     return false
    #   end
    # when "SOSS"
    #   if Time.current.in_time_zone('Hong Kong').between?(@SOSSstart, @SOSSend)
    #     return true
    #   else
    #     return false
    #   end
    # when "SOSE"
    #   if Time.current.in_time_zone('Hong Kong').between?(@SOSEstart, @SOSEend)
    #     return true
    #   else
    #     return false
    #   end
    # when "SOM"
    #   if Time.current.in_time_zone('Hong Kong').between?(@SOMstart, @SOMend)
    #     return true
    #   else
    #     return false
    #   end
    # end
   

    # case self.school
    # when "SOM"
    #   if Time.current.in_time_zone('Hong Kong').between?(@somspecialstart, @somspecialend)
    #     return true
    #   else
    #     return false
    #   end
    # else 
    #   return false
    # end

    # if Time.current.in_time_zone('Hong Kong').between?(@specialstart, @specialend)
    #   return true
    # else
    #   return false
    # end



  end


  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      #raise conditions.inspect
      if login = conditions.delete(:id)
        where(conditions.to_hash).where(["student_id = :value", { :value => login }]).first
      else
        where(conditions.to_hash).first
      end
    end
  def create_or_update
    raise ReadOnlyRecord, "#{self.class} is marked as readonly" if readonly?
    account = Account.where(student_id: self.student_id).first
    if account
      self.id = account.id
    end
    result = new_record? ? _create_record : _update_record
    result != false
  end

  # create_or_update comes from persistence.rb

  def self.to_csv(options = {})
    (CSV.generate(options) do |csv|
      columns = %w(student_id name school yr course full_course double_major second_status minor cellphone_number email writeup feedback)
      csv << columns
      all.each do |account|
        csv << account.attributes.values_at(*columns)
      end
    end).encode('WINDOWS-1252', :undef => :replace, :replace => '')
  end

end
