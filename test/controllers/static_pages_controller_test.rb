require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase

  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "e-Learn web site"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Help | e-Learn web site"
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "About | e-Learn web site"
  end

  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "Contact | e-Learn web site"
  end

end
