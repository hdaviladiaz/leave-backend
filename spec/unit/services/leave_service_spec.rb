require 'rails_helper'
require 'json'

describe LeaveService, type: :service do
  let(:people) { '{"preferredName":"Name"}' }
  let(:jigsaw_token) { Faker::Crypto.sha1 }
  let(:uri) { "https://jigsaw.thoughtworks.net/api/people#{params}" }
  let(:user) { User.new(Faker::Internet.email) }
  let(:token) { Token.new.encode(user) }
  let(:params) { '' }
  before do
    stub_request(:get, uri).to_return(body: people, status: 200)
    ENV['JWT_SECRET'] = Faker::Crypto.sha256
  end
  describe '#create' do
    let(:params) { "/#{user.username}" }
    let(:date) { Faker::Date.backward(50) }
    let(:validRequest) do
      {
        employee_id: user.email,
        approver_id: user.email,
        start_date: date.next_day(60),
        end_date: date.next_day(65),
        return_date: date.next_day(66)
      }
    end

    it 'sould create leave-request when valid parameters are provided' do
      leave_request = JSON.parse(validRequest.to_json)
      expect(LeaveService.create(leave_request).persisted?).to eq(true)
    end
  end
end
