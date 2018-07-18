class CreateTableSubjectsTutors < ActiveRecord::Migration[5.2]
  def change
  	create_join_table :subjects, :tutors do |t|
      t.belongs_to :tutor, index: true
      t.belongs_to :subject, index: true
      t.timestamps
    end
  end
end
