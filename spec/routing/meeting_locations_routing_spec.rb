require "rails_helper"

RSpec.describe MeetingLocationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/meeting_locations").to route_to("meeting_locations#index")
    end

    it "routes to #new" do
      expect(:get => "/meeting_locations/new").to route_to("meeting_locations#new")
    end

    it "routes to #show" do
      expect(:get => "/meeting_locations/1").to route_to("meeting_locations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/meeting_locations/1/edit").to route_to("meeting_locations#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/meeting_locations").to route_to("meeting_locations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/meeting_locations/1").to route_to("meeting_locations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/meeting_locations/1").to route_to("meeting_locations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/meeting_locations/1").to route_to("meeting_locations#destroy", :id => "1")
    end

  end
end
