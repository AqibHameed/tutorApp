class CreateTutors < ActiveRecord::Migration[5.2]
  def change
    create_table :tutors do |t|
      t.string :education ,null: false
      t.string :experience , null: false
      t.string :availablity ,null: false
      t.belongs_to :user, foreign_key: true , null: false
      t.timestamps
    end
  end
end
