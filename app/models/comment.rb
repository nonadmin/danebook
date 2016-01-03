class Comment < ActiveRecord::Base
  include Likeable

  default_scope { order('created_at ASC') }

  attr_accessor :parent_id

  belongs_to :author, class_name: "User"
  belongs_to :commentable, polymorphic: true

  validates :author, :commentable_type, :commentable_id, presence: true
  validates :body, length: { in: 12..2000 } 


  after_create do
    Comment.delay.send_new_comment_email(self.id)
  end


  private


  def self.send_new_comment_email(comment_id)
    comment = Comment.find_by_id(comment_id)
    CommentMailer.new_comment(comment).deliver_now
  end
  
end
