class Photo < ActiveRecord::Base
  include Likeable
  include Commentable

  belongs_to :author, class_name: "User"

  has_attached_file :image, styles: { large: "1000x800>", 
                                      small: "150x150>", 
                                      thumb: "64x64#" } 
                        
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :image, less_than: 2.megabytes
  validates :image, attachment_presence: true
  validates :author, presence: true
end
