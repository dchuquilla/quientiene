# Preview all emails at http://localhost:3000/rails/mailers/replacement_mailer
class ReplacementMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/replacement_mailer/new_request
  def new_request
    user = User.find 3
    replacement_request = ReplacementRequest.find 2
    ReplacementMailer.new_request user, replacement_request
  end

  # Preview this email at http://localhost:3000/rails/mailers/replacement_mailer/new_proposal
  def new_proposal
    user = User.find 3
    replacement_proposal = ReplacementProposal.find 1
    ReplacementMailer.new_proposal user, replacement_proposal
  end

  # Preview this email at http://localhost:3000/rails/mailers/replacement_mailer/proposal_accepted
  def proposal_accepted
    user = User.find 3
    replacement_proposal = ReplacementProposal.find 1
    ReplacementMailer.proposal_accepted user, replacement_proposal
  end

end
