require 'test_helper'

class AjaxControllerTest < ActionController::TestCase
  test "should get campus" do
    get :campus
    assert_response :success
  end

end
