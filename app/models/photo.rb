class Photo < ActiveRecord::Base
  include Likeable
  include Commentable

  attr_accessor :url

  belongs_to :author, class_name: "User"

  # These are horribly named but are never referenced in the application
  # We just want to make sure the dependent nullify to fire if the photo
  # is deleted.
  has_one :profile_set_as_cover, foreign_key: :cover_photo_id, 
                                 class_name: "Profile", dependent: :nullify
  has_one :profile_set_as_profile, foreign_key: :profile_photo_id, 
                                 class_name: "Profile", dependent: :nullify

  has_attached_file :image, 
      styles: { large: "1000x800>", small: "300x300#", thumb: "64x64#" },
      default_url: ->(attachment) { 
        ActionController::Base.helpers.asset_path('missing_large.png') }

                        
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :image, less_than: 5.megabytes
  validates :image, attachment_presence: true, unless: "url.present?"
  validates :author, presence: true

  before_validation :image_from_url

  process_in_background :image

  private
  

  def image_from_url
    unless self.url.blank?
      begin
        self.image = URI.parse(self.url)
      rescue
        errors.add(:url, "There was a problem with the URL you entered")
      end
    end
  end

end
