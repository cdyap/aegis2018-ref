class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:student_id]
  belongs_to :timeslot
  belongs_to :groupshot
  validates :writeup, length: { maximum: 505 }
  validates :cellphone_number, :numericality => true, :allow_blank => true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :update }
  # validates_numericality_of :cellphone_number, :only_integer => true, on: :updates
  # validates_presence_of :cellphone_number, on: :update
  validates_uniqueness_of :email, on: :update, unless: Proc.new { |user| Account.where(name: user.name).first && Account.where(name: user.name).first.email.include?(user.email) }
  
  def to_s
    "#{self.student_id}, #{self.name}, #{self.yr} - #{self.course}"
  end

  def yearbook_shot
    begin
      @casualshot = Student.find(self.student_id).page_number
      return "/pics/"+@casualshot.to_s+".pdf"
    rescue
      return ""
    end
  end

  def toga_shots
    begin
      return CoursePage.select('page_number').where(course: self.course).order('page_number')
    rescue
      return ""
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
    @time = Time.now
    # @time = Time.new(2017, 10, 21, 23,01)
    if @time.between?(@groupstart1, @groupend2)
      return true
    else 
      return false
    end
  end

  def can_submit_writeup
    @writeup_start = Time.new(2017,10,30)
    @writeup_end = Time.new(2017,12,12)
    @time = Time.now

    if @time.between?(@writeup_start, @writeup_end)
      return true
    else
      return false
    end
  end

  def can_signup
    @feedback_start = Time.new(2018,3,4)
    @feedback_end = Time.new(2018,3,7)
    if Time.now.between?(@feedback_start, @feedback_end)
      return true
    else
      return false
    end
  end

  def inactive_message
  
    return "Feedback submission is from March 4 to 6."
  end

  def can_login
    if self.email == "cdyap@outlook.com"
      return true
    end
    # Feedback start end times
    @feedback_start = Time.new(2018,3,4)
    @feedback_end = Time.new(2018,3,7)
    if Time.now.between?(@feedback_start, @feedback_end)
      return true
    else
      return false
    end
    #2017 start end times
    # @SOHstart = Time.new(2017, 10, 16, 7)
    # @SOHend = Time.new(2017, 10, 16, 23)

    # @SOSSstart = Time.new(2017, 10, 17, 7)
    # @SOSSend = Time.new(2017, 10, 17, 23)

    # @SOSEstart = Time.new(2017, 10, 18, 7)
    # @SOSEend = Time.new(2017, 10, 18, 23)

    # @SOMstart = Time.new(2017, 10, 19, 7)
    # @SOMend = Time.new(2017, 10, 19, 23)

    # @groupstart1 = Time.new(2017, 10, 20, 7)
    # @groupend1 = Time.new(2017, 10, 20, 23)

    # @groupstart2 = Time.new(2017, 10, 21, 7)
    # @groupend2 = Time.new(2017, 10, 21, 23)

    # #if time is between group sign ups, return true
    # #if time is later than last time of group sign ups, return false
    # if Time.now.between?(@groupstart1, @groupend1)
    #   return true
    # elsif Time.now.between?(@groupstart2, @groupend2)
    #   return true
    # elsif Time.now > @groupend2
    #   return false
    # end

    # #return sign in times based on school
    # case self.school
    # when "SOH" 
    #   if Time.now.between?(@SOHstart, @SOHend)
    #     return true
    #   else
    #     return false
    #   end
    # when "SOSS"
    #   if Time.now.between?(@SOSSstart, @SOSSend)
    #     return true
    #   else
    #     return false
    #   end
    # when "SOSE"
    #   if Time.now.between?(@SOSEstart, @SOSEend)
    #     return true
    #   else
    #     return false
    #   end
    # when "SOM"
    #   if Time.now.between?(@SOMstart, @SOMend)
    #     return true
    #   else
    #     return false
    #   end
    # end
    # return false
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
      column_names = %w(student_id name school yr course full_course double_major second_status minor cellphone_number email feedback)
      # names = column_names << "timeslot"
      csv << column_names

      all.each do |account|
        row_values = account.attributes.values_at(*column_names)
        csv << row_values
      end
    end).encode('WINDOWS-1252', :undef => :replace, :replace => '')
  end

end
