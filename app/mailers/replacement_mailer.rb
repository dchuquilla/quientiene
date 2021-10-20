# frozen_string_literal: true

# Send emails for replacemnts
class ReplacementMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.replacement_mailer.new_request.subject
  #
  def new_request(user, replacement_request)
    @mail_title = 'Un cliente solicita repuestos'
    @mail_subject = 'Nueva solicitud de repuesto'
    @replacement_request = replacement_request

    mail to: user.email, subject: @mail_subject
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.replacement_mailer.new_proposal.subject
  #
  def new_proposal(user, replacement_proposal)
    @mail_title = 'Un local comercial envió una propuesta'
    @mail_subject = 'Nueva propuesta enviada'
    @replacement_proposal = replacement_proposal

    mail to: user.email, subject: @mail_subject
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.replacement_mailer.proposal_accepted.subject
  #
  def proposal_accepted(user, replacement_proposal)
    @mail_title = 'Su propuesta fue aceptada'
    @mail_subject = 'Su propuesta fue aceptada'
    @replacement_proposal = replacement_proposal

    mail to: user.email, subject: @mail_subject
  end
end
