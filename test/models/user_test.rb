require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "create user" do
    u = User.new email: 'me@example.com', password: 'foobar', full_name: 'someone new'
    u.save!
  end
end
