class Tutor < ApplicationRecord
  belongs_to :user
validates :education ,presence: true
validates :experience ,presence: true
validates :availablity ,presence: true
end