class AddWaitingStatusToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :waiting_status, :integer, default:0
  end
end
