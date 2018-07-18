class AddColumntosubject < ActiveRecord::Migration[5.2]
  def change
  	add_column :subjects, :approved , :boolean , default:true
  end
end
