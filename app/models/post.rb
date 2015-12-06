class Post < ActiveRecord::Base
  default_scope { order('created_at DESC') }

  belongs_to :author, foreign_key: "user_id", class_name: "User"

  validates :user_id, presence: true
  validates :body, presence: true, length: { in: 12..2000 }

end
