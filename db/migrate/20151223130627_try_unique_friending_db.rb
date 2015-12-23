class TryUniqueFriendingDb < ActiveRecord::Migration
  def change
    remove_index :friendings, [:friender_id, :friend_id]
    add_index :friendings, [:friender_id, :friend_id], unique: true
  end
end
