# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/signup_email
  def signup_email
    UserMailer.signup_email
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/send_email
  def send_email
    UserMailer.send_email
  end

end
