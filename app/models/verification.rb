class Verification < ApplicationRecord
  #associations
  belongs_to :user
  #validations
  validates :verification_type, presence: :true
  validates :verification_status ,presence: :true ,inclusion: {in:VARIFICATION_STATUS_RANGE} #0: pending 1: verified 2: delayed
  validates :verification_pin ,presence: :true # should be created somewhere


  before_validation :generate_pin, on: :create # before validation means that
  after_create :send_mail

  private

  def generate_pin
    begin
      self.verification_pin = SecureRandom.random_number(VERIFICATION_PIN_LENGTH)
    end while self.class.exists?(verification_pin: self.verification_pin)
  end

  def send_mail
    if self.verification_type == VERIFICATION_TYPE_STANDARD
      VerificationMailer.verify_pin(self).deliver_later
    elsif self.verification_type == VERIFICATION_TYPE_RESET
      VerificationMailer.reset_pin(self).deliver_later
    end
  end
end
