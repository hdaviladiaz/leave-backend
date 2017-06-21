require 'rails_helper'

describe User do
  subject(:user) { User.new(email) }
  let(:email) { Faker::Internet.email }

  describe '#initialize' do
    it 'should assign email address' do
      expect(user.email).to eq(email)
    end

    it 'should extract username from email address' do
      username = email.split('@')[0]
      expect(user.username).to eq(username)
    end
  end
end
