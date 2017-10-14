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
    @SOHstart = Time.new(2017, 10, 16, 7)
    @SOHend = Time.new(2017, 10, 16, 23)

    @SOSSstart = Time.new(2017, 10, 17, 7)
    @SOSSend = Time.new(2017, 10, 17, 23)

    @SOSEstart = Time.new(2017, 10, 18, 7)
    @SOSEend = Time.new(2017, 10, 18, 23)

    @SOMstart = Time.new(2017, 10, 19, 7)
    @SOMend = Time.new(2017, 10, 19, 23)

    # @groupstart1 = Time.new(2016, 10, 6, 23).in_time_zone('Hong Kong')
    # @groupend1 = Time.new(2016, 10, 7, 15).in_time_zone('Hong Kong')

    # @groupstart2 = Time.new(2016, 10, 7, 23).in_time_zone('Hong Kong')
    # @groupend2 = Time.new(2016, 10, 8, 15).in_time_zone('Hong Kong')

    # @somspecialstart = Time.new(2016, 10, 8, 23).in_time_zone('Hong Kong')
    # @somspecialend = Time.new(2016, 10, 9, 15).in_time_zone('Hong Kong')

    @time = Time.now
    case self.school
    when "SOH" 
        return "Time now is " + @time.strftime("%l:%M %p") + ". You may only login between " + @SOHstart.strftime("%b %d, %l:%M %p") + " and " + @SOHend.strftime("%l:%M %p")  +". "
    when "SOSS"
        return "Time now is " + @time.strftime("%l:%M %p") + ". You may only login between " + @SOSSstart.strftime("%b %d, %l:%M %p")  + " and " + @SOSSend.strftime("%l:%M %p") +". "
    when "SOSE"
      return "Time now is " + @time.strftime("%l:%M %p") + ". You may only login between " + @SOSEstart.strftime("%b %d, %l:%M %p")  + " and " + @SOSEend.strftime("%l:%M %p") +". "
    when "SOM"
      return "Time now is " + @time.strftime("%l:%M %p") + ". You may only login between " + @SOMstart.strftime("%b %d, %l:%M %p")  + " and " + @SOMend.strftime("%l:%M %p") +". "
    end

    return "Sign ups are from October 16 to 21."
  end

  def can_login
    # return true

    @SOHstart = Time.new(2017, 10, 16, 7)
    @SOHend = Time.new(2017, 10, 16, 23)

    @SOSSstart = Time.new(2017, 10, 17, 7)
    @SOSSend = Time.new(2017, 10, 17, 23)

    @SOSEstart = Time.new(2017, 10, 18, 7)
    @SOSEend = Time.new(2017, 10, 18, 23)

    @SOMstart = Time.new(2017, 10, 19, 7)
    @SOMend = Time.new(2017, 10, 19, 23)

    @groupstart1 = Time.new(2016, 10, 6, 23).in_time_zone('Hong Kong')
    @groupend1 = Time.new(2016, 10, 7, 15).in_time_zone('Hong Kong')

    @groupstart2 = Time.new(2016, 10, 7, 23).in_time_zone('Hong Kong')
    @groupend2 = Time.new(2016, 10, 8, 15).in_time_zone('Hong Kong')

    @somspecialstart = Time.new(2016, 10, 8, 23).in_time_zone('Hong Kong')
    @somspecialend = Time.new(2016, 10, 9, 15).in_time_zone('Hong Kong')

    @specialstart = Time.new(2016, 10, 9, 16).in_time_zone('Hong Kong')
    @specialend = Time.new(2016, 10, 13, 15).in_time_zone('Hong Kong')


    case self.school
    when "SOH" 
      if Time.now.between?(@SOHstart, @SOHend)
        return true
      else
        return false
      end
    when "SOSS"
      if Time.now.between?(@SOSSstart, @SOSSend)
        return true
      else
        return false
      end
    when "SOSE"
      if Time.now.between?(@SOSEstart, @SOSEend)
        return true
      else
        return false
      end
    when "SOM"
      if Time.now.between?(@SOMstart, @SOMend)
        return true
      else
        return false
      end
    end
   

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
