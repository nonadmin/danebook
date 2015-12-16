class Post < ActiveRecord::Base
  include Likeable
  include Commentable

  default_scope { order('created_at DESC') }

  belongs_to :author, foreign_key: "user_id", class_name: "User"

  validates :author, presence: true
  validates :body, presence: true, length: { in: 12..2000 }

end
