require "active_support/concern"

module Likeable
  extend ActiveSupport::Concern

  included do
    has_many :likes, as: :likeable, dependent: :destroy
    has_many :likers, through: :likes, source: :creator
  end
  
  
  def like_id_for(current_user)
    if likers.ids.include?(current_user.id)
      likes.where("creator_id = ?", current_user.id).first.id
    end
  end
end