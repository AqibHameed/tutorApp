class Student < ApplicationRecord
  #Association
  belongs_to :user
  has_many :requests
  has_many :jobs
  #Validation
  validates :price ,presence: true
end