require "test_helper"

class ReplacementMailerTest < ActionMailer::TestCase
  test "new_request" do
    mail = ReplacementMailer.new_request
    assert_equal "New request", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "new_proposal" do
    mail = ReplacementMailer.new_proposal
    assert_equal "New proposal", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "proposal_accepted" do
    mail = ReplacementMailer.proposal_accepted
    assert_equal "Proposal accepted", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
