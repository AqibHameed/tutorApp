class CreateTutors < ActiveRecord::Migration[5.2]
  def change
    create_table :tutors do |t|
      t.string :education
      t.string :experience
      t.string :availablity
      t.belongs_to :user, foreign_key: true , null: false
      t.timestamps
    end
  end
end
