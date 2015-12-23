class CreateFriendings < ActiveRecord::Migration
  def change
    create_table :friendings do |t|
      t.integer :friender_id
      t.integer :friend_id

      t.timestamps null: false
    end
    add_index :friendings, [:friender_id, :friend_id], unique: true
  end
end
