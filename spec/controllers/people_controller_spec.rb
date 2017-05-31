require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  describe "GET #index" do
    context "to be successful" do
      it "get success response" do
        get :index
        expect(response).to be_success
      end

      it "get a array" do
        get :index
        expect(JSON(response.body)).to be_kind_of(Array)
      end

      it "get no empty array" do
        get :index
        expect(JSON(response.body)).not_to be_empty
      end
    end
  end

  describe "GET #show" do
    context "to be successful" do
      it "get success response" do
        get :show, params: {id: "20774"}
        expect(response).to be_success
      end

      it "get a json" do
        get :show, params: {id: "20774"}
        expect(response.content_type).to eq('application/json')
      end
    end
  end
end
