class Request < ApplicationRecord
  # validates :status ,presence: true
  after_update :active_user

  belongs_to :tutor, optional: true
  belongs_to :student, optional: true
  belongs_to :subject, optional: true

  def active_user

    if self.acceptance == true && self.subject_id.nil?

      if self.tutor_id.present?
         tutor = self.tutor

         if tutor.present?
             tutor.user.update(user_status: 1)
         end

      elsif self.student_id.present?
        student = self.student

        if student.present?
          student.user.update(user_status: 1)
        end

      end

    end

  end

end
