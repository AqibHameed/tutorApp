class CreateNewsLetters < ActiveRecord::Migration[5.2]
  def change
    create_table :news_letters do |t|
      t.string :email
      t.integer :user_id
      t.integer :student_id
      t.integer :tutor_id

      t.timestamps
    end
  end
end
