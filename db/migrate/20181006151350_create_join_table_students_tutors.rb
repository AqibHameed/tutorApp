class CreateJoinTableStudentsTutors < ActiveRecord::Migration[5.2]
  def change
    create_join_table :students, :tutors do |t|
      t.index [:student_id, :tutor_id]
      t.index [:tutor_id, :student_id]
    end
  end
end
