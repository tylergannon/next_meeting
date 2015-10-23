require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe MeetingsController, type: :controller do
  render_views

  let(:today) {
    Weekday.find_by name: Time.zone.now.strftime('%A')
  }

  let(:meeting_location) {create :meeting_location}
  let(:meeting_group)    {create :meeting_group}
  let(:valid_attributes) {
    {
      meeting_location_id: meeting_location.id,
      name: 'Bleeding Deacons',
      start_time: '16:30',
      weekday_ids: [today.id],
      meeting_group_id: meeting_group.id
    }
  }

  let(:valid_attributes_with_location) {
    {
      name: 'Bleeding Deacons',
      start_time: '16:30',
      weekday_ids: [today.id],
      meeting_group_id: meeting_group.id,
      location_attributes: {
        name: 'A Church',
        address1: '123 N. 8th St',
        address2: 'Apt 1',
        city: 'Brooklyn',
        state: 'NY',
        postal_code: '11249',
        latlon: "POINT (-73.9526078 40.7158034)",
        notes: 'Blah blah'
      }
    }
  }


  let(:invalid_attributes) {
    {
      name: ''
    }
  }

  let(:meeting) {Meeting.create! valid_attributes}
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MeetingsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  RSpec.shared_examples "Index Actions" do
    describe "GET #[action]" do
      it "assigns all meetings as @meetings" do
        get action, params, valid_session
        aggregate_failures do
          expect(assigns(:meetings)).to have(1).items
          expect(assigns(:meetings)).to eq([meeting])
        end
      end
    end
  end

  describe "GET #index" do
    before {meeting}
    let(:action){:index}
    let(:params){{}}
    it_behaves_like("Index Actions")
  end

  describe "Get #search" do
    let(:latitude) {40.7110184}
    let(:longitude) {-73.9451092}
    let(:radius) {5} # Miles
    let(:action) {:search}
    let(:params) {{
      format: :json,
      search: {
        latitude: latitude,
        longitude: longitude,
        radius: radius
      }
    }}
    let(:meeting) {Meeting.create! valid_attributes_with_location}
    let(:another_meeting) {
      attribs = valid_attributes_with_location.clone
      attribs[:location_attributes][:latlon] = "POINT (73.9526078 40.7158034)" # Far away
      Meeting.create! attribs
    }
    before {meeting; another_meeting}
    it "has stuff" do
      aggregate_failures do
        expect(Meeting.find_near(latitude, longitude, Unit('20 miles'))).not_to be_empty
      end
    end
    it_behaves_like("Index Actions")
  end

  describe "GET #show" do
    it "assigns the requested meeting as @meeting" do
      meeting = Meeting.create! valid_attributes
      get :show, {:id => meeting.to_param}, valid_session
      expect(assigns(:meeting)).to eq(meeting)
    end
  end

  describe "GET #new" do
    it "assigns a new meeting as @meeting" do
      get :new, {}, valid_session
      expect(assigns(:meeting)).to be_a_new(Meeting)
    end
  end

  describe "GET #edit" do
    it "assigns the requested meeting as @meeting" do
      meeting = Meeting.create! valid_attributes
      get :edit, {:id => meeting.to_param}, valid_session
      expect(assigns(:meeting)).to eq(meeting)
    end
  end

  RSpec.shared_examples "Meeting Creation" do
    describe "POST #create" do
      context "with valid params" do
        context "when meeting location was selected from list" do
          it "creates a new Meeting" do
            expect {
              post :create, {:meeting => valid_attributes}, valid_session
            }.to change(Meeting, :count).by(1)
          end

          it "assigns a newly created meeting as @meeting" do
            post :create, {:meeting => valid_attributes}, valid_session
            expect(assigns(:meeting)).to be_a(Meeting)
            expect(assigns(:meeting)).to be_persisted
          end

          it "redirects to the created meeting" do
            post :create, {:meeting => valid_attributes}, valid_session
            expect(response).to redirect_to(Meeting.last)
          end
        end
      end
      context "with invalid params" do
        it "assigns a newly created but unsaved meeting as @meeting" do
          post :create, {:meeting => invalid_attributes}, valid_session
          expect(assigns(:meeting)).to be_a_new(Meeting)
        end

        it "re-renders the 'new' template" do
          post :create, {:meeting => invalid_attributes}, valid_session
          expect(response).to render_template("new")
        end
      end
    end
  end

  describe "Creating a new meeting by selecting location from a list" do
    it_behaves_like("Meeting Creation")
  end

  describe "Creating a new meeting by typing in the address" do
    let(:valid_attributes) {valid_attributes_with_location}
    it_behaves_like("Meeting Creation")
  end

  describe "PUT #update" do
    before {meeting}
    context "with valid params" do
      let(:weekday_ids) { [Weekday.monday, Weekday.tuesday].map &:id }
      let(:another_location) {create :another_real_place}
      let(:new_attributes) {
        {
          meeting_location_id: another_location.id,
          name: 'Another Name',
          weekday_ids: weekday_ids
        }
      }
      let(:do_update) {put :update, {:id => meeting.to_param, :meeting => new_attributes}, valid_session}

      it "updates the requested meeting" do
        do_update
        meeting.reload
        aggregate_failures do
          expect(response).to be_redirect
          expect(meeting.weekday_ids).to eq(weekday_ids)
          expect(meeting.location).to eq(another_location)
          expect(meeting.name).to eq('Another Name')
        end
      end

      it "assigns the requested meeting as @meeting" do
        put :update, {:id => meeting.to_param, :meeting => valid_attributes}, valid_session
        expect(assigns(:meeting)).to eq(meeting)
      end

      it "redirects to the meeting" do

        put :update, {:id => meeting.to_param, :meeting => valid_attributes}, valid_session
        expect(response).to redirect_to(meeting)
      end
    end

    context "with invalid params" do
      it "assigns the meeting as @meeting" do

        put :update, {:id => meeting.to_param, :meeting => invalid_attributes}, valid_session
        expect(assigns(:meeting)).to eq(meeting)
      end

      it "re-renders the 'edit' template" do

        put :update, {:id => meeting.to_param, :meeting => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested meeting" do
      meeting = Meeting.create! valid_attributes
      expect {
        delete :destroy, {:id => meeting.to_param}, valid_session
      }.to change(Meeting, :count).by(-1)
    end

    it "redirects to the meetings list" do
      meeting = Meeting.create! valid_attributes
      delete :destroy, {:id => meeting.to_param}, valid_session
      expect(response).to redirect_to(meetings_url)
    end
  end

end
