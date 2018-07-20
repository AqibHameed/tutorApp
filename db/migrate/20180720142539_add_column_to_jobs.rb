class AddColumnToJobs < ActiveRecord::Migration[5.2]
  def change
    add_reference :jobs, :student, foreign_key: true
  end
end
