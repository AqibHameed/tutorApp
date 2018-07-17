class Request < ApplicationRecord
  # validates :status ,presence: true	
  belongs_to :tutor
  belongs_to :student
  belongs_to :subject
end
