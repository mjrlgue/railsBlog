require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:marwane)
    @micropost = @user.microposts.build(content: "Something awesome")
  end

  test "shoud be valid" do 
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "content  should be present" do
    @micropost.content = "   "
    assert_not @micropost.valid?
  end

  test "content  should be at most 140 char" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end

  test "order should be most recent first" do
    assert_equal Micropost.first, microposts(:recent)
  end
end
