class Student < ApplicationRecord
  #Association
  belongs_to :user
  has_many :requests
  has_many :jobs
  has_and_belongs_to_many :tutors
  #Validation
  #validates :price ,presence: true
end