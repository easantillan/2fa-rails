class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable, :recoverable, :rememberable, :validatable, :two_factor_authenticatable,
          :otp_secret_encryption_key => ENV['2FA_KEY']

  enum type_otp: %i[email qr not_set]

  # URI for OTP two-factor QR code
  def two_factor_qr_code_uri
    issuer = ENV['OTP_2FA_ISSUER_NAME']
    label = [issuer, email].join(':')

    otp_provisioning_uri(label, issuer: issuer)
  end
end
