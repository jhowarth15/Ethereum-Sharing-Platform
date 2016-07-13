require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path
    assert_template 'home_page/home'
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", search_items_path
  end


end
