class User < ApplicationRecord
  has_one :tutor , dependent: :destroy
  has_one :student , dependent: :destroy
  validates :name ,presence: true
  validates :role ,presence: true  ,inclusion: {in: USER_TYPE_RANGE} # 0 for Student 1 for Teacher 2 for both
end
