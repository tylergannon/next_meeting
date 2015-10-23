class MeetingLocationsController < ApplicationController
  before_action :set_meeting_location, only: [:show, :edit, :update, :destroy]
  after_action :geocode_location, only: [:create, :update], if: :model_valid?

  # GET /meeting_locations
  # GET /meeting_locations.json
  def index
    @meeting_locations = MeetingLocation.all
  end

  # GET /meeting_locations/1
  # GET /meeting_locations/1.json
  def show
  end

  # GET /meeting_locations/new
  def new
    @meeting_location = MeetingLocation.new
  end

  # GET /meeting_locations/1/edit
  def edit
  end

  # POST /meeting_locations
  # POST /meeting_locations.json
  def create
    @meeting_location = MeetingLocation.new(meeting_location_params)

    respond_to do |format|
      if @meeting_location.save
        format.html { redirect_to @meeting_location, notice: 'Meeting location was successfully created.' }
        format.json { render :show, status: :created, location: @meeting_location }
      else
        format.html { render :new }
        format.json { render json: @meeting_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meeting_locations/1
  # PATCH/PUT /meeting_locations/1.json
  def update
    respond_to do |format|
      if @meeting_location.update(meeting_location_params)
        format.html { redirect_to @meeting_location, notice: 'Meeting location was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting_location }
      else
        format.html { render :edit }
        format.json { render json: @meeting_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meeting_locations/1
  # DELETE /meeting_locations/1.json
  def destroy
    @meeting_location.destroy
    respond_to do |format|
      format.html { redirect_to meeting_locations_url, notice: 'Meeting location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting_location
      @meeting_location = MeetingLocation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meeting_location_params
      params.require(:meeting_location).permit(:name, :address1, :address2, :city, :state, :postal_code, :latitude, :longitude, :notes)
    end

    def model_valid?
      @meeting_location.valid?
    end

    def geocode_location
      GeocodeLocationJob.perform_later(@meeting_location)
    end
end
