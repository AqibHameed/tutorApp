class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.integer :price ,null: false
      t.datetime :timing
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
