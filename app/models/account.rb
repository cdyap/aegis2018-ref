class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:student_id]
  belongs_to :timeslot
  belongs_to :groupshot
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

  def get_groupslot
    Groupslot.find_by(id: self.groupshot_id)
  end

  def active_for_authentication?
    super and self.can_login
  end

  def can_signup_for_group
    @groupstart1 = Time.new(2017, 10, 20, 7)
    @groupend2 = Time.new(2017, 10, 21, 23)
    if Time.now.between?(@groupstart1, @groupend2)
      return true
    else 
      return false
    end
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

    @groupstart1 = Time.new(2017, 10, 20, 7)
    @groupend1 = Time.new(2017, 10, 20, 23)

    @groupstart2 = Time.new(2017, 10, 21, 7)
    @groupend2 = Time.new(2017, 10, 21, 23)

    # @somspecialstart = Time.new(2016, 10, 8, 23).in_time_zone('Hong Kong')
    # @somspecialend = Time.new(2016, 10, 9, 15).in_time_zone('Hong Kong')

    @time = Time.now

    if Time.now > @SOMend
      return "Time now is " + @time.strftime("%l:%M %p") + ". You may only login between 7:00 AM and 11:00 PM of " + @groupstart1.strftime("%b %d") + " and " +@groupstart2.strftime("%b %d")
    else 
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
    end

    return "Sign ups are from October 16 to 21."
  end

  def can_login
    #2017 start end times
    @SOHstart = Time.new(2017, 10, 16, 7)
    @SOHend = Time.new(2017, 10, 16, 23)

    @SOSSstart = Time.new(2017, 10, 17, 7)
    @SOSSend = Time.new(2017, 10, 17, 23)

    @SOSEstart = Time.new(2017, 10, 18, 7)
    @SOSEend = Time.new(2017, 10, 18, 23)

    @SOMstart = Time.new(2017, 10, 19, 7)
    @SOMend = Time.new(2017, 10, 19, 23)

    @groupstart1 = Time.new(2017, 10, 20, 7)
    @groupend1 = Time.new(2017, 10, 20, 23)

    @groupstart2 = Time.new(2017, 10, 21, 7)
    @groupend2 = Time.new(2017, 10, 21, 23)

    #if time is between group sign ups, return true
    #if time is later than last time of group sign ups, return false
    if Time.now.between?(@groupstart1, @groupend1)
      return true
    elsif Time.now.between?(@groupstart2, @groupend2)
      return true
    elsif Time.now > @groupend2
      return false
    end

    #return sign in times based on school
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
    return false
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
      column_names = %w(student_id name school yr course full_course double_major second_status minor cellphone_number email)
      names = column_names << "timeslot"
      csv << names
      all.each do |account|
        row_values = account.attributes.values_at(*column_names).insert(-1, account.get_timeslot)
        csv << row_values
      end
    end).encode('WINDOWS-1252', :undef => :replace, :replace => '')
  end

end
