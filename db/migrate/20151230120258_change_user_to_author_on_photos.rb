class ChangeUserToAuthorOnPhotos < ActiveRecord::Migration
  def change
    remove_index :photos, :user_id
    remove_column :photos, :user_id
    add_column :photos, :author_id, :integer, null: false
    add_index :photos, :author_id
  end
end
