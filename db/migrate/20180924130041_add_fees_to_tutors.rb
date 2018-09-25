class AddFeesToTutors < ActiveRecord::Migration[5.2]
  def change
    add_column :tutors, :fees, :string
  end
end
