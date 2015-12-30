class Photo < ActiveRecord::Base
  include Likeable
  include Commentable
    
  belongs_to :author, class_name: "User"

  has_attached_file :image, styles: { large: "1000x800>", small: "150x150>", thumb: "64x64#" }, 
                            default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
