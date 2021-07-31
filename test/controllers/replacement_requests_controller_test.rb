require "test_helper"

class ReplacementRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @replacement_request = replacement_requests(:one)
  end

  test "should get index" do
    get replacement_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_replacement_request_url
    assert_response :success
  end

  test "should create replacement_request" do
    assert_difference('ReplacementRequest.count') do
      post replacement_requests_url, params: { replacement_request: { vehicle_id: @replacement_request.vehicle_id, description: @replacement_request.description, part_number: @replacement_request.part_number, short_name: @replacement_request.short_name, user_id: @replacement_request.user_id } }
    end

    assert_redirected_to replacement_request_url(ReplacementRequest.last)
  end

  test "should show replacement_request" do
    get replacement_request_url(@replacement_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_replacement_request_url(@replacement_request)
    assert_response :success
  end

  test "should update replacement_request" do
    patch replacement_request_url(@replacement_request), params: { replacement_request: { vehicle_id: @replacement_request.vehicle_id, description: @replacement_request.description, part_number: @replacement_request.part_number, short_name: @replacement_request.short_name, user_id: @replacement_request.user_id } }
    assert_redirected_to replacement_request_url(@replacement_request)
  end

  test "should destroy replacement_request" do
    assert_difference('ReplacementRequest.count', -1) do
      delete replacement_request_url(@replacement_request)
    end

    assert_redirected_to replacement_requests_url
  end
end
