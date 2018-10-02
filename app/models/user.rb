class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, password_length: 8..20
  #rolify
  #associations
  has_one :auth , dependent: :destroy
  has_one :tutor , dependent: :destroy
  has_one :student , dependent: :destroy
  has_many :sessions, dependent: :destroy
  has_many :verifications, dependent: :destroy
  #validation
  validates :user_type , presence: :true ,inclusion: {in: USER_TYPE_RANGE} # 1 general, 0 admin
  validates :name, presence: :true
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Incorrect email format"
  validates :email,presence: true ,uniqueness: true
  validates :username ,presence: true ,uniqueness: true
  validates :user_status ,presence: true ,inclusion: {in: USER_STATUS_RANGE} # 1 active, 0 blocked
  accepts_nested_attributes_for :tutor, allow_destroy: true
  accepts_nested_attributes_for :student, allow_destroy: true
  #validates :gender  #true for male && false for female


end
