class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id,     null: false
      t.string :first_name,   null: false
      t.string :last_name,    null: false
      t.datetime :birthday,   null: false
      t.string :gender
      t.text :about
      t.text :quote
      t.string :college
      t.string :hometown
      t.string :current_location
      t.string :phone

      t.timestamps null: false
    end
  end
end
