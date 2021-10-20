# frozen_string_literal: true

# Parent class for mailes, you can define global methods and vars
class ApplicationMailer < ActionMailer::Base
  default from: 'info@quientiene.com'
  layout 'mailer'
end
