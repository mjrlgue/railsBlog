require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:marwane)
  end

  test "unseccessful edit profile" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name: "", 
                 email: "user@notvalid",
                 password: "bar",
                 password_confirmation: "foo"}
    assert_template 'users/edit'
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    patch user_path(@user), user: { name: "Foo Bar", 
                 email: "user@valid.com",
                 password: "",
                 password_confirmation: ""}
    assert_not flash.empty?
    assert_redirected_to @users
    #reload users attibutes
    @user.reload
    #make sure that attributes had changed
    assert_equal @user.name, "Foo Bar"
    assert_equal @user.email, "user@valid.com"


  end
end
