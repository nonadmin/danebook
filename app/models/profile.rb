class Profile < ActiveRecord::Base
  belongs_to :user

  validates :first_name, :last_name, :birthday, presence: true 
  validate :age_allowed


  # Make sure the extremely young and the potentially immortal can't sign up
  def age_allowed
    if birthday && birthday.year < Date.today.year - 90
      errors.add(:birthday, "You are potentially a vampire, please leave") 
    elsif birthday && birthday.year > Date.today.year - 12
      errors.add(:birthday, "Sorry junior, you're too young to ride")
    end
  end

end
