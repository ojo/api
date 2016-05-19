require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "create user" do
    u = User.new email: 'me@example.com', password: 'foobar'
    u.save!
  end
end
