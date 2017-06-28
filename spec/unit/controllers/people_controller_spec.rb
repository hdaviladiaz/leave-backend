require 'rails_helper'

describe PeopleController, type: :controller do
  let(:jigsaw_token) { Faker::Crypto.sha1 }
  let(:user) { User.new(Faker::Internet.email) }
  let(:people) {"[{\"employeeId\":\"16247\",\"loginName\":\"#{user.username}\"},{\"employeeId\":\"16247\",\"loginName\":\"arodrig\"}]"}
  let(:uri) { "https://jigsaw.thoughtworks.net/api/people#{params}" }
  let(:token) { Token.new.encode(user) }
  before do
    stub_request(:get, uri).to_return(body: people, status: code)
    ENV['JWT_SECRET'] = Faker::Crypto.sha256
  end

  describe '#index' do
    let(:params) { '?home_office=Quito' }

    context 'when user is logged in' do
      subject(:response) do
        request.headers[:Token] = token
        get :index
      end

      context 'when request is authorized' do
        let(:code) { 200 }
        it { is_expected.to have_http_status(200) }
        specify { expect(response.body).to eq(people) }
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

   describe '#index_except_me' do
    let(:params) { '?home_office=Quito' }
    let(:peopleResponse) {"[{\"employeeId\":\"16247\",\"loginName\":\"arodrig\"}]"}

    context 'when user is logged in' do
      subject(:response) do
        request.headers[:Token] = token
        get :index_except_me
      end

      context 'when request is authorized' do
        let(:code) { 200 }
        it { is_expected.to have_http_status(200) }
        specify { expect(response.body).to eq(peopleResponse) }
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
 

  describe '#show' do
    let(:params) { "/#{user.username}" }

    context 'when user is logged in' do
      subject(:response) do
        request.headers[:Token] = token
        get :show
      end

      context 'when request is authorized' do
        let(:code) { 200 }
        it { is_expected.to have_http_status(200) }
        specify { expect(response.body).to eq(people) }
      end

      context 'when request is not authorized' do
        let(:code) { 401 }
        specify { expect(response).to have_http_status(401) }
      end
    end

    context 'when user is anonymous' do
      context 'whithout token header' do
        subject(:response) { get :show }
        let(:code) { 200 }
        it { is_expected.to have_http_status(303) }
      end

      context 'with undefined token header' do
        subject(:response) do
          request.headers[:Token] = 'undefined'
          get :show
        end
        let(:code) { 200 }
        it { is_expected.to have_http_status(303) }
      end
    end
  end
end
