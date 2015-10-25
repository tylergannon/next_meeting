class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]
  after_action :geocode_meeting_location, only: [:create, :update], if: :meeting_valid?

  # GET /meetings
  # GET /meetings.json
  def index
    @meetings = Meeting.all
  end

  def search
    @user_location = [search_params[:latitude], search_params[:longitude]]
    @meetings = Meeting.limit(5).decorate
    if false && search_params[:latitude] && search_params[:longitude]

      @search_radius = search_params[:radius] || 10
      @meetings = Meeting.find_near(@user_location[0], @user_location[1], Unit(@search_radius, 'miles')).
        by_day_of_week(Time.zone.now.strftime('%A')).limit(15).decorate
      if @meetings.empty?
        @meetings = Meeting.find_near(@user_location[0], @user_location[1], Unit(@search_radius, 'miles')).
          limit(5).decorate
      end
      puts @meetings.count
    end

    respond_to do |format|
      format.json do
        render 'index'
      end
    end
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
    @meeting = @meeting.decorate
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
    @meeting.build_location unless @meeting.location.present?
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to @meeting, notice: 'Meeting was successfully created.' }
        format.json { render :show, status: :created, location: @meeting }
      else
        @meeting.build_location unless @meeting.location
        format.html { render :new }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    @meeting.attributes = meeting_params
    @meeting.save
    respond_to do |format|
      if @meeting.valid?
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meetings_url, notice: 'Meeting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    def meeting_params
      if params[:meeting] && params[:meeting][:meeting_location_id].present?
        params.require(:meeting).permit(:meeting_location_id, :meeting_group_id, :name, :start_time, weekday_ids: [])
      else
        params.require(:meeting).permit(:meeting_group_id, :name, :start_time, weekday_ids: [], location_attributes: [:name, :address1, :address2, :city, :state, :postal_code, :notes])
      end
    end

    def search_params
      params.permit(:latitude, :longitude, :radius, :weekday, :starts_before, :starts_after)
    end

    def geocode_meeting_location
      GeocodeLocationJob.perform_later @meeting.location
    end

    def meeting_valid?
      @meeting.valid?
    end
end
