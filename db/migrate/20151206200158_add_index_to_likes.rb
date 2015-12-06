class AddIndexToLikes < ActiveRecord::Migration
  def change
    add_index :likes, [:creator_id, :likeable_id, :likeable_type], unique: true
  end
end
