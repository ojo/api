require 'rails_helper'

RSpec.describe AuthController, :type => :controller do
  it 'returns a token given valid login credentials'
    # expect(JSON.parse(response.body)[:token]).to eq(u.)
  it 'returns json given valid login credentials' do
    u = User.create!(email:'eg@example.com', password:'foobar')
    get :new, params: { email: u.email, password: u.password }
    expect(response.status).to eq(200)
    expect(response.content_type).to eq "application/json"
  end

  it 'returns 400 when creds not provided' do
    get :new
    expect(response.status).to eq(400)
  end
end
