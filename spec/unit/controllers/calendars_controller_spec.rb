require 'rails_helper'

describe CalendarsController, type: :controller do
  let(:calendar) { Faker::Lorem.sentence }
  let(:jigsaw_token) { Faker::Crypto.sha1 }
  let(:uri) { JIGSAW_CALENDAR_URL+"#{params}" }
  let(:user) { User.new(Faker::Internet.email) }
  let(:token) { Token.new.encode(user) }

  before do
    stub_request(:get, uri).to_return(body: calendar, status: code)
    ENV['JWT_SECRET'] = Faker::Crypto.sha256
  end

  describe '#index' do
    let(:params) { "/#{HOME_OFFICE}/#{Time.zone.now.year}" }

    context 'when user is logged in' do
      subject(:response) do
        request.headers[:Token] = token
        get :index
      end

      context 'when request is authorized' do
        let(:code) { 200 }
        it { is_expected.to have_http_status(200) }
        specify { expect(response.body).to eq(calendar) }
      end

      context 'when request is not authorized' do
        let(:code) { 401 }
        specify { expect(response).to have_http_status(401) }
      end
    end

    context 'when user is anonymous' do
      context 'whithout token header' do
        subject(:response) { get :index }
        let(:code) { 200 }
        it { is_expected.to have_http_status(303) }
      end

      context 'with undefined token header' do
        subject(:response) do
          request.headers[:Token] = 'undefined'
          get :index
        end
        let(:code) { 200 }
        it { is_expected.to have_http_status(303) }
      end
    end
  end
end
