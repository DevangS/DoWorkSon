require 'test_helper'

class TextControllerTest < ActionController::TestCase
  test "should get sendtext" do
    get :sendtext
    assert_response :success
  end

end
