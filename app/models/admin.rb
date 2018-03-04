class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  self.primary_key = :id


  def create_or_update
    raise ReadOnlyRecord, "#{self.class} is marked as readonly" if readonly?
    account = Admin.where(id: self.id).first
    if account
      self.id = account.id
    end
    result = new_record? ? _create_record : _update_record
    result != false
  end
end
