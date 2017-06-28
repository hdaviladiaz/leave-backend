require 'rails_helper'

describe LeaveRequestsController, type: :controller do
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

  let(:userAdmin) { User.new(ADMIN_USERS.split(',')[0] + '@thoughtworks.com') }
  let(:tokenAdmin) { Token.new.encode(userAdmin) }

  let(:valid_attributes) do
    {
      start_date: Faker::Date.forward(10),
      end_date: Faker::Date.forward(10),
      return_date: Faker::Date.forward(10),
      employee_id: Faker::Internet.email,
      approver_id: Faker::Internet.email,
      status: [:pending, :approved, :rejected, :taken, :not_taken].sample
    }
  end

  let(:invalid_attributes) do
    {
      start_date: nil,
      end_date: Faker::Date.forward(10),
      return_date: Faker::Date.forward(10),
      employee_id: Faker::Number.between(1, 10),
      approver_id: Faker::Number.between(1, 10)
    }
  end

  before do
    request.headers[:Token] = token
  end

  describe 'GET #index' do
    it 'returns 401 response' do
      get :index, params: {}
      expect(response).to have_http_status(401)
    end

    it 'returns a success response' do
      request.headers[:Token] = tokenAdmin
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe 'GET #approve' do
    it 'returns 303 response' do
      request.headers[:Token] = ''
      get :approve, params: {}
      expect(response).to have_http_status(303)
    end

    it 'returns a success response' do
      request.headers[:Token] = tokenAdmin
      get :approve, params: {}
      expect(response).to be_success
    end
  end

  describe 'GET #me' do
    it 'returns 303 response' do
      request.headers[:Token] = ''
      get :me, params: {}
      expect(response).to have_http_status(303)
    end

    it 'returns a success response' do
      request.headers[:Token] = tokenAdmin
      get :me, params: {}
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      leave_request = LeaveRequest.create! valid_attributes
      get :show, params: { id: leave_request.to_param }
      expect(response).to be_success
    end
  end

   describe 'GET #taken_leaves' do    
    it 'returns 303 response' do
      request.headers[:Token] = ''
      get :taken_leaves, params: {}
      expect(response).to have_http_status(303)
    end

    it 'returns a success response' do
      request.headers[:Token] = tokenAdmin
      get :taken_leaves, params: {}
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    let(:params) { "/#{user.username}" }
    context 'with valid params' do
      it 'creates a new LeaveRequest' do
        expect do
          post :create, params: { leave_request: valid_attributes }
        end.to change(LeaveRequest, :count).by(1)
      end

      it 'renders a JSON response with the new leave_request' do
        post :create, params: { leave_request: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(leave_request_url(LeaveRequest.last))
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new leave_request' do
        post :create, params: { leave_request: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:start_date) { Faker::Date.forward(10) }
      let(:end_date) { Faker::Date.forward(10) }
      let(:return_date) { Faker::Date.forward(10) }
      let(:employee_id) { Faker::Internet.email }
      let(:approver_id) { Faker::Internet.email }
      let(:new_attributes) do
        {
          start_date: start_date,
          end_date: end_date,
          return_date: return_date,
          employee_id: employee_id,
          approver_id: approver_id
        }
      end

      it 'updates the requested leave_request' do
        leave_request = LeaveRequest.create! valid_attributes
        put :update, params: { id: leave_request.to_param, leave_request: new_attributes }
        leave_request.reload
        expect(leave_request['start_date']).to eq(start_date)
        expect(leave_request['end_date']).to eq(end_date)
        expect(leave_request['return_date']).to eq(return_date)
        expect(leave_request['employee_id']).to eq(employee_id.to_s)
      end

      it 'renders a JSON response with the leave_request' do
        leave_request = LeaveRequest.create! valid_attributes
        put :update, params: { id: leave_request.to_param, leave_request: valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the leave_request' do
        leave_request = LeaveRequest.create! valid_attributes

        put :update, params: { id: leave_request.to_param, leave_request: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested leave_request' do
      leave_request = LeaveRequest.create! valid_attributes
      expect do
        delete :destroy, params: { id: leave_request.to_param }
      end.to change(LeaveRequest, :count).by(-1)
    end
  end
end
