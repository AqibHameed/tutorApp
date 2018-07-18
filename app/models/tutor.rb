class Tutor < ApplicationRecord
  belongs_to :user
  has_many :requests
  has_and_belongs_to_many :subjects
  validates :education ,presence: true
  validates :experience ,presence: true
  validates :availablity ,presence: true
end