require 'test_helper'

class HomePageControllerTest < ActionController::TestCase
 
  test "should get home" do
    get :index
    assert_response :success
    assert_select "title", "Home"
  end

end
