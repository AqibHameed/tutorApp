class NewsLetter < ApplicationRecord

  validates :email, presence: true

  belongs_to :user, optional: true
  belongs_to :student, optional: true
  belongs_to :tutor, optional: true

end
