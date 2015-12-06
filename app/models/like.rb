class Like < ActiveRecord::Base
  belongs_to :likeable, polymorphic: true
  belongs_to :creator, class_name: "User"

  validates :likeable_id, :likeable_type, :creator_id, presence: true
  validates_uniqueness_of :likeable_type, scope: [:likeable_id, :creator_id],
                          message: "can only be liked once!"
end
