class Post < ActiveRecord::Base
  default_scope { order('created_at DESC') }

  belongs_to :author, foreign_key: "user_id", class_name: "User"
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :likers, through: :likes, source: :creator

  validates :user_id, presence: true
  validates :body, presence: true, length: { in: 12..2000 }


  def like_id_for(user)
    if likers.ids.include?(user.id)
      likes.where("creator_id = ?", user.id).first.id
    end
  end

end
