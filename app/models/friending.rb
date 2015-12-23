class Friending < ActiveRecord::Base
  after_create  :complete_friending

  belongs_to :friend_receiver, foreign_key: :friend_id,
                               class_name: "User"

  belongs_to :friend_initiator, foreign_key: :friender_id,
                                class_name: "User"

  validates_uniqueness_of :friend_initiator, scope: [:friend_receiver]


  private


  # Two-way friendships are automatic and don't require confirmation
  # A new friending is created with the inverse of the first
  def complete_friending
    f = Friending.new(friend_initiator: friend_receiver, 
                      friend_receiver: friend_initiator)
    f.save
  end

end
