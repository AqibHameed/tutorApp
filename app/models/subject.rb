class Subject < ApplicationRecord
  #associations
  has_many :requests
  has_many :jobs
  has_and_belongs_to_many :tutors
  #validation
  validates :name ,presence: true, uniqueness: true
end
