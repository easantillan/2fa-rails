class UsersOtpController < ApplicationController
  before_action :authenticate_user!
  def enable
    current_user.otp_secret = User.generate_otp_secret
    current_user.otp_required_for_login = true
    current_user.save!
    redirect_back(fallback_location:root_path)
  end

  def disable
  end

end