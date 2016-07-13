require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(user_id: "user_test", name_first: "User", name_last: "Test", email: "user@example.com")
  end

  test "should be valid" do
    assert @user.valid?
  end

  # BEGIN TESTS FOR IF USER INPUT IS PRESENT
  test "user_id should be present" do
    @user.user_id = "     "
    assert_not @user.valid?
  end

  test "name_first should be present" do
    @user.name_first = "     "
    assert_not @user.valid?
  end

  test "name_last should be present" do
    @user.name_last = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "      "
    assert_not @user.valid?
  end
  # END TESTS FOR IF USER INPUT IS PRESENT

  # BEGIN TESTS FOR USER INPUT LENGTH VALIDATION
  test "user_id should not be too long" do
    @user.user_id = "a" * 26
    assert_not @user.valid?
  end

  test "name_first should not be too long" do
    @user.name_first = "a" * 51
    assert_not @user.valid?
  end

  test "name_last should not be too long" do
    @user.name_last = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  # END TESTS FOR USER INPUT LENGTH VALIDATION

  # BEGIN TEST VALID EMAIL ADDRESS FORMAT
  test "email validation should accept valid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. 
				foo@bar_baz.com foo@bar+baz.com]
    
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  # END TEST VALID EMAIL ADDRESS FORMAT

  # BEGIN TEST FOR REJECTION OF DUPLICATES
  test "user_ids and email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase #emails are case-insensitive
    @user.save
    assert_not duplicate_user.valid?
  end
  # END TEST FOR REJECTION OF DUPLICATES
end
