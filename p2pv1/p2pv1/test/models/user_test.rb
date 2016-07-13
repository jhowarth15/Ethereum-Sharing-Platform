require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(user_id: "Example User", postcode: "XXXXXX", email: "user@example.com")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.user_id = ""
    assert_not @user.valid?
  end

  test "postcode should be present" do
    @user.postcode = ""
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end
end
