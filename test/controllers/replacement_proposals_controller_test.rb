require "test_helper"

class ReplacementProposalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @replacement_proposal = replacement_proposals(:one)
  end

  test "should get index" do
    get replacement_proposals_url
    assert_response :success
  end

  test "should get new" do
    get new_replacement_proposal_url
    assert_response :success
  end

  test "should create replacement_proposal" do
    assert_difference('ReplacementProposal.count') do
      post replacement_proposals_url, params: { replacement_proposal: { brand: @replacement_proposal.brand, conditions: @replacement_proposal.conditions, delivery_time: @replacement_proposal.delivery_time, life_time: @replacement_proposal.life_time, name: @replacement_proposal.name, origin: @replacement_proposal.origin, original: @replacement_proposal.original, price: @replacement_proposal.price, shop_id: @replacement_proposal.shop_id, target: @replacement_proposal.target, user_id: @replacement_proposal.user_id } }
    end

    assert_redirected_to replacement_proposal_url(ReplacementProposal.last)
  end

  test "should show replacement_proposal" do
    get replacement_proposal_url(@replacement_proposal)
    assert_response :success
  end

  test "should get edit" do
    get edit_replacement_proposal_url(@replacement_proposal)
    assert_response :success
  end

  test "should update replacement_proposal" do
    patch replacement_proposal_url(@replacement_proposal), params: { replacement_proposal: { brand: @replacement_proposal.brand, conditions: @replacement_proposal.conditions, delivery_time: @replacement_proposal.delivery_time, life_time: @replacement_proposal.life_time, name: @replacement_proposal.name, origin: @replacement_proposal.origin, original: @replacement_proposal.original, price: @replacement_proposal.price, shop_id: @replacement_proposal.shop_id, target: @replacement_proposal.target, user_id: @replacement_proposal.user_id } }
    assert_redirected_to replacement_proposal_url(@replacement_proposal)
  end

  test "should destroy replacement_proposal" do
    assert_difference('ReplacementProposal.count', -1) do
      delete replacement_proposal_url(@replacement_proposal)
    end

    assert_redirected_to replacement_proposals_url
  end
end
