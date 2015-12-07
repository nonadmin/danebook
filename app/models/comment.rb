class Comment < ActiveRecord::Base
  attr_accessor :parent_id

  belongs_to :author, class_name: "User"
  belongs_to :commentable, polymorphic: true

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :likers, through: :likes, source: :creator

  validates :author_id, :commentable_type, :commentable_id, presence: true
  validates :body, length: { in: 12..2000 } 


  def like_id_for(user)
    if likers.ids.include?(user.id)
      likes.where("creator_id = ?", user.id).first.id
    end
  end

end
