class Tutor < ApplicationRecord
  belongs_to :user
  has_many :requests
  validates :education ,presence: true
  validates :experience ,presence: true
  validates :availablity ,presence: true
end