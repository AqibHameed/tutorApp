class Request < ApplicationRecord
  # validates :status ,presence: true
  after_update :active_user

  belongs_to :tutor, optional: true
  belongs_to :student, optional: true
  belongs_to :subject, optional: true

  def active_user

   if self.acceptance == true && student_id.present? && tutor_id.present? && subject_id.nil?
        @student = Student.find_by(id: student_id)
        @tutor = Tutor.find_by(id: tutor_id)
        @student.tutors << @tutor unless @student.tutors.include?(@tutor)
   end
    # if self.acceptance == true && self.subject_id.nil?
    #
    #   if self.tutor_id.present?
    #      tutor = self.tutor
    #
    #      if tutor.present?
    #          tutor.user.update(user_status: 1)
    #      end
    #
    #   elsif self.student_id.present?
    #     student = self.student
    #
    #     if student.present?
    #       student.user.update(user_status: 1)
    #     end
    #
    #   end
    #
    # end

  end

end
