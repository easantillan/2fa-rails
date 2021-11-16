# Preview all emails at http://localhost:3000/rails/mailers/code_mailer
class CodeMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/code_mailer/send_code
  def send_code
    CodeMailer.send_code
  end

end
