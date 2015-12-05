class User < ActiveRecord::Base
  has_secure_password
  before_create :generate_token

  validates :first_name, :last_name, :email, :birthday, :gender, presence: true 
  validates :email, uniqueness: true
  validate :age_allowed
  validates :password, length: { in: 8..64 },
                       format: { with: /(?=.*\d)(?=.*([a-z]))(?=.*([A-Z])).{8,}/,
                                 message: "requires 1 Uppercase, 1 lowercase, and 1 digit" },
                       allow_nil: true

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end


  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(auth_token: self[:auth_token])
  end

  # Make sure the extremely young and the potentially immortal can't sign up
  def age_allowed
    if birthday.year < Date.today.year - 150
      errors.add(:birthday, "You are potentially a vampire, please leave") 
    elsif birthday.year > Date.today.year - 12
      errors.add(:birthday, "Sorry junior, you're too young to ride")
    end
  end


end
