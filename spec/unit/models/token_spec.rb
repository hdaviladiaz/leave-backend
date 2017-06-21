require 'rails_helper'
require 'jwt'

describe Token do
  subject(:token) { Token.new }
  let(:user) { User.new(Faker::Internet.email) }
  let(:jwt_secret) { Faker::Crypto.sha256 }
  let(:payload) { user.instance_values }
  let(:rol) { '0' }

  before(:each) { ENV['JWT_SECRET'] = jwt_secret }

  it 'should encode user' do
    expected_encoded = JWT.encode(payload, jwt_secret, JWT_ALGORITHM) + rol
    encoded_token = token.encode(user)
    expect(encoded_token).to eq(expected_encoded)
  end

  it 'should decode token' do
    provided_token = JWT.encode(payload, jwt_secret, JWT_ALGORITHM) + rol
    decoded_user = token.decode(provided_token)
    expect(decoded_user).to have_attributes(payload)
  end
end
