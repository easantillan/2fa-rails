class SessionsController < Devise::SessionsController
  before_action :authenticate_2fa!, only: [:create]

  def authenticate_2fa!
    user = self.resource = find_user
    return unless user

    if user_params[:otp_attempt].present?
      auth_with_2fa(user)
    elsif user.valid_password?(user_params[:password]) && user.otp_required_for_login && user.type_otp.eql?('email')
      session[:user_id] = user.id
      CodeMailer.send_code(user).deliver_now
      return render "users_otp/two_fa"
    elsif user.valid_password?(user_params[:password]) && user.otp_required_for_login && user.type_otp.eql?('qr')
      session[:user_id] = user.id
      return render "users_otp/two_fa_qr"
    end
  end

  def auth_with_2fa(user)
    return unless user.validate_and_consume_otp!(user_params[:otp_attempt])
    user.save!
    sign_in(user)
  end

  def find_user
    if session[:user_id]
      User.find(session[:user_id])
    elsif user_params[:email]
      return User.find_by(email: user_params[:email])
    end
  end

  def user_params
    params.fetch(:user, {}).permit(:password, :otp_attempt, :email, :remember_me)
  end

end