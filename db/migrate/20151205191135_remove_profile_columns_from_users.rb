class RemoveProfileColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :gender
    remove_column :users, :birthday
    remove_column :users, :about
    remove_column :users, :quote
    remove_column :users, :college
    remove_column :users, :home_town
    remove_column :users, :current_town
    remove_column :users, :phone
  end
end
