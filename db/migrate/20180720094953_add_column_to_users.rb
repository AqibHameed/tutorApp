class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email, :string , null:false
    add_column :users, :username, :string , null:false
    add_column :users, :about, :string
    add_column :users, :gender, :boolean , null:false
    add_column :users, :user_status, :integer ,default:1
    rename_column :users, :role, :user_type
  end
end
