require 'test_helper'

class SlackWebhookControllerTest < ActionController::TestCase
  test "should get incoming_message" do
    get :incoming_message
    assert_response :success
  end

end
