require "application_system_test_case"

class ReplacementProposalsTest < ApplicationSystemTestCase
  setup do
    @replacement_proposal = replacement_proposals(:one)
  end

  test "visiting the index" do
    visit replacement_proposals_url
    assert_selector "h1", text: "Replacement Proposals"
  end

  test "creating a Replacement proposal" do
    visit replacement_proposals_url
    click_on "New Replacement Proposal"

    fill_in "Brand", with: @replacement_proposal.brand
    fill_in "Conditions", with: @replacement_proposal.conditions
    fill_in "Delivery time", with: @replacement_proposal.delivery_time
    fill_in "Life time", with: @replacement_proposal.life_time
    fill_in "Name", with: @replacement_proposal.name
    fill_in "Origin", with: @replacement_proposal.origin
    check "Original" if @replacement_proposal.original
    fill_in "Price", with: @replacement_proposal.price
    fill_in "Shop", with: @replacement_proposal.shop_id
    fill_in "Target", with: @replacement_proposal.target
    fill_in "User", with: @replacement_proposal.user_id
    click_on "Create Replacement proposal"

    assert_text "Replacement proposal was successfully created"
    click_on "Back"
  end

  test "updating a Replacement proposal" do
    visit replacement_proposals_url
    click_on "Edit", match: :first

    fill_in "Brand", with: @replacement_proposal.brand
    fill_in "Conditions", with: @replacement_proposal.conditions
    fill_in "Delivery time", with: @replacement_proposal.delivery_time
    fill_in "Life time", with: @replacement_proposal.life_time
    fill_in "Name", with: @replacement_proposal.name
    fill_in "Origin", with: @replacement_proposal.origin
    check "Original" if @replacement_proposal.original
    fill_in "Price", with: @replacement_proposal.price
    fill_in "Shop", with: @replacement_proposal.shop_id
    fill_in "Target", with: @replacement_proposal.target
    fill_in "User", with: @replacement_proposal.user_id
    click_on "Update Replacement proposal"

    assert_text "Replacement proposal was successfully updated"
    click_on "Back"
  end

  test "destroying a Replacement proposal" do
    visit replacement_proposals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Replacement proposal was successfully destroyed"
  end
end
