class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup_email.subject
  #
  def signup_email
    @user    = params[:user]
    receiver = @user.email
    sender   = "info@quientiene.com"
    subject  = "Mesaje de bienvenida"

    # The HTML body of the email
    htmlbody = render_to_string(:partial => 'user_mailer/email_template.html.erb', :layout => false, :locals => {:user => @user})
   
    # send email
    send_email(receiver, sender, subject, htmlbody)
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.send_email.subject
  #
  def send_email
    region = "us-east-2"

   # Specify the text encoding scheme.
   encoding = "UTF-8" 
   # configure SES session
   ses = Aws::SES::Client.new(
      region: region,
      access_key_id: ENV['AWS_ACCESS_KEY_ID'], 
      secret_access_key: ENV['AWS_ACCESS_KEY_ID']
    )

   begin
      ses.send_email({
        destination: {
          to_addresses: [receiver],
        },
        message: {
          body: {
            html: {
              charset: encoding,
              data: htmlbody,
            }
          },
          subject: {
            charset: encoding,
            data: subject,
          },
        },
        source: sender,
      })
      puts "Email sent!"
    rescue Aws::SES::Errors::ServiceError => error
      puts "Email not sent. Error message: #{error}"
    end
  end
end
