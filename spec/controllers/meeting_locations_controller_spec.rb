require 'rails_helper'

RSpec.describe MeetingLocationsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # MeetingLocation. As you add validations to MeetingLocation, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      name: 'A Place',
      address1: '2129 Crosspoint Ave',
      address1: 'Apt 1',
      city: 'Santa Rosa',
      state: 'CA',
      postal_code: '95403'
    }
  }

  let(:invalid_attributes) {
    {name: 'Invalid Place', address1: '', city: ''}
  }

  let(:meeting_location) {create :meeting_location, valid_attributes}

  let(:valid_session) { {} }

  describe "GET #index" do
    before {meeting_location}
    it "assigns all meeting_locations as @meeting_locations" do
      get :index, {}, valid_session
      expect(assigns(:meeting_locations)).to eq([meeting_location])
    end
  end

  describe "GET #show" do
    it "assigns the requested meeting_location as @meeting_location" do

      get :show, {:id => meeting_location.to_param}, valid_session
      expect(assigns(:meeting_location)).to eq(meeting_location)
    end
  end

  describe "GET #new" do
    it "assigns a new meeting_location as @meeting_location" do
      get :new, {}, valid_session
      expect(assigns(:meeting_location)).to be_a_new(MeetingLocation)
    end
  end

  describe "GET #edit" do
    it "assigns the requested meeting_location as @meeting_location" do

      get :edit, {:id => meeting_location.to_param}, valid_session
      expect(assigns(:meeting_location)).to eq(meeting_location)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new MeetingLocation" do
        expect {
          VCR.use_cassette 'geocoder/meetings_controller/create meeting' do
            post :create, {:meeting_location => valid_attributes}, valid_session
          end
        }.to change(MeetingLocation, :count).by(1)
      end

      it "assigns a newly created meeting_location as @meeting_location" do
        VCR.use_cassette 'geocoder/meetings_controller/create meeting' do
          post :create, {:meeting_location => valid_attributes}, valid_session
        end
        expect(assigns(:meeting_location)).to be_a(MeetingLocation)
        expect(assigns(:meeting_location)).to be_persisted
      end

      it "redirects to the created meeting_location" do
        VCR.use_cassette 'geocoder/meetings_controller/create meeting' do
          post :create, {:meeting_location => valid_attributes}, valid_session
        end
        expect(response).to redirect_to(MeetingLocation.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved meeting_location as @meeting_location" do
        post :create, {:meeting_location => invalid_attributes}, valid_session
        expect(assigns(:meeting_location)).to be_a_new(MeetingLocation)
      end

      it "re-renders the 'new' template" do
        post :create, {:meeting_location => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    before {meeting_location}
    context "with valid params" do
      let(:new_attributes) {
        {
          name: 'New Name',
          address1: '151 Kent Ave',
          city: 'Brooklyn',
          state: 'NY',
          postal_code: '11249'
        }
      }

      it "updates the requested meeting_location" do
        put :update, {:id => meeting_location.to_param, :meeting_location => new_attributes}, valid_session
        meeting_location.reload
      end

      it "assigns the requested meeting_location as @meeting_location" do
        put :update, {:id => meeting_location.to_param, :meeting_location => valid_attributes}, valid_session
        expect(assigns(:meeting_location)).to eq(meeting_location)
      end

      it "redirects to the meeting_location" do
        put :update, {:id => meeting_location.to_param, :meeting_location => valid_attributes}, valid_session
        expect(response).to redirect_to(meeting_location)
      end
    end

    context "with invalid params" do
      it "assigns the meeting_location as @meeting_location" do
        put :update, {:id => meeting_location.to_param, :meeting_location => invalid_attributes}, valid_session
        expect(assigns(:meeting_location)).to eq(meeting_location)
      end

      it "re-renders the 'edit' template" do
        put :update, {:id => meeting_location.to_param, :meeting_location => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do

    before {meeting_location}
    it "destroys the requested meeting_location" do

      expect {
        delete :destroy, {:id => meeting_location.to_param}, valid_session
      }.to change(MeetingLocation, :count).by(-1)
    end

    it "redirects to the meeting_locations list" do

      delete :destroy, {:id => meeting_location.to_param}, valid_session
      expect(response).to redirect_to(meeting_locations_url)
    end
  end

end
