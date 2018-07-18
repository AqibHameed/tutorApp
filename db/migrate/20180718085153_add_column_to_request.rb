class AddColumnToRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :acceptance, :boolean , default:false
  end
end
