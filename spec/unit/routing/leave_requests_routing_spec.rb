require "rails_helper"

RSpec.describe LeaveRequestsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/leave_requests").to route_to("leave_requests#index")
    end

    it "routes to #taken_leaves" do
      expect(:get => "/leave_requests/taken_leaves").to route_to("leave_requests#taken_leaves")
    end

    it "routes to #available_leave_days" do
      expect(:get => "/leave_requests/me/available_leave_days").to route_to("leave_requests#available_leave_days")
    end

    it "routes to #show" do
      expect(:get => "/leave_requests/1").to route_to("leave_requests#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/leave_requests").to route_to("leave_requests#create")
    end

    it 'routes to #approved' do
      expect(:get => "/leave_requests/approved").to route_to("leave_requests#approved")
    end

     it 'routes to #rejected' do
      expect(:get => "/leave_requests/rejected").to route_to("leave_requests#rejected")
    end
    
    it "routes to #update via PUT" do
      expect(:put => "/leave_requests/1").to route_to("leave_requests#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/leave_requests/1").to route_to("leave_requests#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/leave_requests/1").to route_to("leave_requests#destroy", :id => "1")
    end

    it "routes to #all_taken" do
      expect(:get => "/leave_requests/all_taken").to route_to("leave_requests#all_taken")
    end

  end
end
