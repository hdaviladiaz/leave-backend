require 'rails_helper'

describe CalendarsController, type: :controller do
  let(:data) {[{data: Faker::Lorem.sentence}]}
  let(:calendar) {data.to_json}
  let(:response_expected) {(data.concat(data)).to_json}

  let(:jigsaw_token) { Faker::Crypto.sha1 }
  let(:user) { User.new(Faker::Internet.email) }
  let(:token) { Token.new.encode(user) }

  before do
    year = Time.zone.now.year
    stub_jigsaw_calendar_request(year);
    stub_jigsaw_calendar_request(year+1);
    ENV['JWT_SECRET'] = Faker::Crypto.sha256
  end

  def stub_jigsaw_calendar_request(year)
    stub_request(:get, JIGSAW_CALENDAR_URL+"/#{HOME_OFFICE}/#{year}").to_return(body: calendar, status: code)
  end

  describe '#index' do
    context 'when user is logged in' do
      subject(:response) do
        request.headers[:Token] = token
        get :index
      end

      context 'when request is authorized' do
        let(:code) { 200 }
        it { is_expected.to have_http_status(200) }
        specify { expect(response.body).to eq(response_expected) }
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
