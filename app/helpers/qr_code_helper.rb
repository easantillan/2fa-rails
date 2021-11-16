module QrCodeHelper
  def qr_code_as_svg
    RQRCode::QRCode.new(user.two_factor_qr_code_uri).as_svg(
      offset: 0,
      color: '000',
      shape_rendering: 'crispEdges',
      module_size: 4,
      standalone: true
    ).html_safe
  end

  def otp_secret
    user.otp_secret
  end

  private

  def user
    User.find(session[:user_id])
  end
end