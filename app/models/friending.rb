class Friending < ActiveRecord::Base
  after_create  :complete_friending
  after_destroy :destroy_opposite

  belongs_to :friend_receiver, foreign_key: :friend_id,
                               class_name: "User"

  belongs_to :friend_initiator, foreign_key: :friender_id,
                                class_name: "User"

  validates_uniqueness_of :friend_initiator, scope: [:friend_receiver]
  validates :friend_initiator, :friend_receiver, presence: true


  private


  # Two-way friendships are automatic and don't require confirmation
  # A new friending is created with the inverse of the first.
  # This could result in a loop if not for the uniqueness validation
  def complete_friending
    f = Friending.new(friend_initiator: friend_receiver, 
                      friend_receiver: friend_initiator)
    f.save
  end


  # Remove both sides of the friendship at once, unless used to avoid 
  # looping/nil class errors when the opposite is destroyed and this method
  # is called again.
  def destroy_opposite
    opposite = Friending.where("friend_id = ? AND friender_id = ?", 
                                friender_id, 
                                friend_id)
    unless opposite.empty?
      opposite.destroy_all
    end
  end
end
