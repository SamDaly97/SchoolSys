require 'test_helper'
require File.dirname(__FILE__) + '/../test_helper'
class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get set_cookie" do
    get home_set_cookie_url
    assert_response :success
  end

  test "should get show_cookie" do
    get home_show_cookie_url
    assert_response :success
  end

  test "should get delete_cookie" do
    get home_delete_cookie_url
    assert_response :success
  end

end
