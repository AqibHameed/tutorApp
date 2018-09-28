class AddTimingToTutors < ActiveRecord::Migration[5.2]
  def change
    add_column :tutors, :timing, :datetime
  end
end
