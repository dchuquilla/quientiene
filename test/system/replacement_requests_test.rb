require "application_system_test_case"

class ReplacementRequestsTest < ApplicationSystemTestCase
  setup do
    @replacement_request = replacement_requests(:one)
  end

  test "visiting the index" do
    visit replacement_requests_url
    assert_selector "h1", text: "Replacement Requests"
  end

  test "creating a Replacement request" do
    visit replacement_requests_url
    click_on "New Replacement Request"

    fill_in "Car id", with: @replacement_request.vehicle_id
    fill_in "Description", with: @replacement_request.description
    fill_in "Part number", with: @replacement_request.part_number
    fill_in "Short name", with: @replacement_request.short_name
    fill_in "User id", with: @replacement_request.user_id
    click_on "Create Replacement request"

    assert_text "Replacement request was successfully created"
    click_on "Back"
  end

  test "updating a Replacement request" do
    visit replacement_requests_url
    click_on "Edit", match: :first

    fill_in "Car id", with: @replacement_request.vehicle_id
    fill_in "Description", with: @replacement_request.description
    fill_in "Part number", with: @replacement_request.part_number
    fill_in "Short name", with: @replacement_request.short_name
    fill_in "User id", with: @replacement_request.user_id
    click_on "Update Replacement request"

    assert_text "Replacement request was successfully updated"
    click_on "Back"
  end

  test "destroying a Replacement request" do
    visit replacement_requests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Replacement request was successfully destroyed"
  end
end
