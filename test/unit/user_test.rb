require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user attributes must be present" do
  	user = User.new

  	assert user.invalid?
  	assert user.errors[:firstname].include?("can't be blank")
  	assert user.errors[:lastname].include?("can't be blank")
  	assert user.errors[:campus_id].include?("must be valid")
  end
end
