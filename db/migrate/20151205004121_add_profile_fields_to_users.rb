class AddProfileFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :about, :text
    add_column :users, :quote, :text
    add_column :users, :college, :string
    add_column :users, :home_town, :string
    add_column :users, :current_town, :string
    add_column :users, :phone, :string
  end
end
