require "test_helper"

class SpeechRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get speech_requests_new_url
    assert_response :success
  end

  test "should get create" do
    get speech_requests_create_url
    assert_response :success
  end

  test "should get show" do
    get speech_requests_show_url
    assert_response :success
  end
end
