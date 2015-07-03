require "test_helper"

class UserTest < ActiveSupport::TestCase

  def user
    @user ||= users(:vic)
  end

  def test_valid
    assert user.valid?
  end

  def test_password_length_validity
    user.password = "1234567"
    refute user.valid?
  end

  test 'password can not be blank' do
    user.password = ""
    refute user.valid?
  end

  def test_maximum_password_validity
    user.password = "a" * 129
    refute user.valid?
  end

  def test_maximum_email_validity
    user.email = "a" * 244 + "example.com"
    refute user.valid?
  end

  def test_user_name_cannot_be_blank
    user.name = ""
    refute user.valid?
  end

  test 'maximum user name is 30' do
    user.name = "a" * 31
    refute user.valid?
  end
end
