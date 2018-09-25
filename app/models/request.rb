class Request < ApplicationRecord
  # validates :status ,presence: true	
  belongs_to :tutor, optional: true
  belongs_to :student, optional: true
  belongs_to :subject, optional: true
end
