class Photo < ActiveRecord::Base
  include Likeable
  include Commentable

  attr_accessor :url

  belongs_to :author, class_name: "User"

  has_attached_file :image, styles: { large: "1000x800>", 
                                      small: "150x150>", 
                                      thumb: "64x64#" } 
                        
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :image, less_than: 5.megabytes
  validates :image, attachment_presence: true, unless: "url.present?"
  validates :author, presence: true

  before_validation :image_from_url

  
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
