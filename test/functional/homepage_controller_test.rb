require 'test_helper'

class HomepageControllerTest < ActionController::TestCase
  test "should get index" do
  	sign_in users(:one)
    get :index
    assert_response :success
  end

end
