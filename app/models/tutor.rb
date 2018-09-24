class Tutor < ApplicationRecord
  #Association
  belongs_to :user
  has_many :requests
  has_many :jobs
  has_and_belongs_to_many :subjects
  #Validations
  #validates :education ,presence: true
  #validates :experience ,presence: true
  #validates :availablity ,presence: true
end