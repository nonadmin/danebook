class User < ActiveRecord::Base
  has_secure_password
  before_create :generate_token
  
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
  validates_associated :profile

  has_many :posts, dependent: :destroy
  has_many :likes, foreign_key: "creator_id", dependent: :destroy
  has_many :comments, foreign_key: "author_id", dependent: :destroy
  has_many :photos, foreign_key: "author_id", dependent: :destroy

  has_many :initiated_friendings, foreign_key: :friender_id,
                                  class_name: "Friending"
  has_many :friends, through: :initiated_friendings,
                     source: :friend_receiver,
                     dependent: :destroy

  validates :profile, presence: true
  validates :email, presence: true, 
                    uniqueness: true
  validates :password, length: { in: 8..64 },
                       format: { with: /(?=.*\d)(?=.*([a-z]))(?=.*([A-Z])).{8,}/,
                                 message: "requires 1 Uppercase, 1 lowercase, and 1 digit" },
                       allow_nil: true

  after_create do
    User.delay.send_welcome_email(self.id)
  end

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


  def newsfeed
    Post.where("user_id = ? OR user_id IN (?)", self.id, self.friends.ids)
  end


  def friends_activity
    Post.where("user_id IN (?)", self.friends.ids)
  end


  # Constructs a gross looking but efficient WHERE query to search
  # first_name and last_name of profiles for each word in the search
  # string (assuming seperation by space)
  def self.search_by_name(search_string)
    unless search_string.blank?
      search_terms = search_string.split
      search_conditions = [(['first_name ILIKE ?'] * 
                          search_terms.length).join(' OR ') + " OR " +
                          (['last_name ILIKE ?'] * 
                          search_terms.length).join(' OR ')] + 
                          search_terms.map { |term| "%#{term}%" } +
                          search_terms.map { |term| "%#{term}%" }

      results = Profile.where(search_conditions)
      find(results.pluck(:user_id)) if results.any?
    end
  end


  def self.with_profile_photos
    User.includes(:profile).where.not(profiles: {profile_photo_id: nil})
  end


  private


  def self.send_welcome_email(user_id)
    user = User.find_by_id(user_id)
    UserMailer.welcome(user).deliver_now
  end

end
