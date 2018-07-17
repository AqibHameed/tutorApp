class Student < ApplicationRecord
  belongs_to :user
  has_many :requests
  validates :price ,presence: true

end