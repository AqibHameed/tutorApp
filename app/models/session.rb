class Session < ApplicationRecord
  #associations
  belongs_to :user
  #prerequisite methods
  before_validation :generate_stoken, on: :create
  #validations
  validates :stoken ,presence: true
  validates :sign_in_status , inclusion: { in: [true,false] } # remember never to use presence:true for boolean attributes

  private
  def generate_stoken
    begin
      self.stoken = SecureRandom.base58(STOKEN_LENGTH)
    end while self.class.exists?(stoken: self.stoken) #using a loop to check uniqueness of stoken
  end
end
