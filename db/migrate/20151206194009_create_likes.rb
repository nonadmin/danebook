class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :creator_id, null: false
      t.integer :likeable_id, null: false
      t.string :likeable_type, null: false

      t.timestamps null: false
    end

    add_index :likes, [:likeable_type, :likeable_id]
  end
end
