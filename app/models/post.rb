class Post < ActiveRecord::Base
  include Likeable

  default_scope { order('created_at DESC') }

  belongs_to :author, foreign_key: "user_id", class_name: "User"

  has_many :comments, as: :commentable, dependent: :destroy
  accepts_nested_attributes_for :comments
  validates_associated :comments, allow_destroy: true,
    reject_if: proc { |attributes| attributes['body'].blank? }

  validates :author, presence: true
  validates :body, presence: true, length: { in: 12..2000 }

end
