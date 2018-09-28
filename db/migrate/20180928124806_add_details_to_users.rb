class AddDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :phone, :string
    add_column :users, :address, :string
    add_column :users, :degree, :string
    add_column :users, :year_of_completion, :string
    add_column :users, :institution, :string
    add_column :users, :majors, :string
    add_column :users, :expectation, :string
    add_column :users, :martial_status, :integer
    add_column :users, :age, :string
  end
end
