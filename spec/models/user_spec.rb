require 'rails_helper'

RSpec.describe User, :type => :model do
  it 'can be created' do
    u = User.new email: 'person@example.com', password: 'foobar'
    u.save!
  end
end
