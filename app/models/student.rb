class Student < ApplicationRecord
  belongs_to :user
  validates :price ,presence: true
 # validates :timing ,presence: true
end