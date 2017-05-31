require "rails_helper"

RSpec.describe PeopleController, type: :routing do
  describe "routing" do
    it "people to #index" do
      expect(:get => "/people").to route_to("people#index")
    end

    it "people to #show" do
      expect(:get => "/people/1").to route_to("people#show", :id => "1")
    end
  end
end
