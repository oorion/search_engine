require "test_helper"

class UserTest < ActiveSupport::TestCase
  should validate_presence_of :email
  should validate_presence_of :password

  test "user can authenticate if valid" do
    user = FactoryGirl.create(:user)

    assert user.authenticate(user.password)
  end

  test "user cannot authenticate if invalid" do
    user = FactoryGirl.build(:user)

    refute user.authenticate("bad password")
  end
end
