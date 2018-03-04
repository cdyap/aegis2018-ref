class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  self.primary_key = :id

  def can_signup
    return false
  end



  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      #raise conditions.inspect
      if login = conditions.delete(:id)
        where(conditions.to_hash).where(["id = :value", { :value => login }]).first
      else
        where(conditions.to_hash).first
      end
  end

  def create_or_update
    raise ReadOnlyRecord, "#{self.class} is marked as readonly" if readonly?
    account = Admin.where(email: self.email).first
    if account
      self.id = account.id
    end
    result = new_record? ? _create_record : _update_record
    result != false
  end
end
