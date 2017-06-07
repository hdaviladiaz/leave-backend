require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  let(:people) { Faker::Lorem.sentence }
  let(:jigsaw_token) { Faker::Crypto.sha1 }
  let(:uri) { "https://jigsaw.thoughtworks.net/api/people?#{params}" }
  before { stub_request(:get, uri).to_return(body: people, status: code) }

  describe '#index' do
    subject(:response) { get :index }
    let(:params) { 'home_office=Quito' }

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

  describe '#show' do
    subject(:response) { get :show, params: { id: people_id } }
    context 'when resource exists' do
      let(:people_id) { Faker::Number.positive }
      let(:params) { "ids=#{people_id}" }
      let(:code) { 200 }

      it { is_expected.to have_http_status(200) }
      specify { expect(response.content_type).to eq('application/json') }
    end
  end
end
