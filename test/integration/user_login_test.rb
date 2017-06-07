require 'test_helper'

  class UserLoginTest < ActionDispatch::IntegrationTest

    def setup
      @user = users(:marwane)
    end

    test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
    end

    #save user session when closing the browser !
    test "login with valid information followed by logout" do
      get login_path
      post login_path, session: { email: @user.email, password: 'password' }
      #after that check if he is logged in
      assert is_logged_in?
      assert_redirected_to @user
      follow_redirect!
      assert_template 'users/show'
      #we don't want to show 'log in ' in the navbar
      assert_select "a[href=?]", login_path,           count: 0
      #we want to show 'log out and profile'
      assert_select "a[href=?]", logout_path
      assert_select "a[href=?]", user_path(@user)
      #after logged in the user, log out !
      delete logout_path
      assert_not is_logged_in?
      assert_redirected_to root_url
      #if the user logout in a second window
      delete logout_path
      follow_redirect!
      assert_select "a[href=?]", login_path
      assert_select "a[href=?]", logout_path,          count: 0
      assert_select "a[href=?]", user_path(@user), count: 0
    end 

    test "login with remembring checkbox" do
      log_in_as(@user, remember_me: '1')
      assert_not_nil cookies['remember_token']
    end

    test "login without remembring checkbox" do
      log_in_as(@user, remember_me: '0')
      assert_nil cookies['remember_token']
    end


end
