require "rails_helper"

RSpec.describe MeetingGroupsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/meeting_groups").to route_to("meeting_groups#index")
    end

    it "routes to #new" do
      expect(:get => "/meeting_groups/new").to route_to("meeting_groups#new")
    end

    it "routes to #show" do
      expect(:get => "/meeting_groups/1").to route_to("meeting_groups#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/meeting_groups/1/edit").to route_to("meeting_groups#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/meeting_groups").to route_to("meeting_groups#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/meeting_groups/1").to route_to("meeting_groups#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/meeting_groups/1").to route_to("meeting_groups#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/meeting_groups/1").to route_to("meeting_groups#destroy", :id => "1")
    end

  end
end
