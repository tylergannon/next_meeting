class MeetingGroupsController < ApplicationController
  before_action :set_meeting_group, only: [:show, :edit, :update, :destroy]

  # GET /meeting_groups
  # GET /meeting_groups.json
  def index
    @meeting_groups = MeetingGroup.all
  end

  # GET /meeting_groups/1
  # GET /meeting_groups/1.json
  def show
  end

  # GET /meeting_groups/new
  def new
    @meeting_group = MeetingGroup.new
  end

  # GET /meeting_groups/1/edit
  def edit
  end

  # POST /meeting_groups
  # POST /meeting_groups.json
  def create
    @meeting_group = MeetingGroup.new(meeting_group_params)

    respond_to do |format|
      if @meeting_group.save
        format.html { redirect_to @meeting_group, notice: 'Meeting group was successfully created.' }
        format.json { render :show, status: :created, location: @meeting_group }
      else
        format.html { render :new }
        format.json { render json: @meeting_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meeting_groups/1
  # PATCH/PUT /meeting_groups/1.json
  def update
    respond_to do |format|
      if @meeting_group.update(meeting_group_params)
        format.html { redirect_to @meeting_group, notice: 'Meeting group was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting_group }
      else
        format.html { render :edit }
        format.json { render json: @meeting_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meeting_groups/1
  # DELETE /meeting_groups/1.json
  def destroy
    @meeting_group.destroy
    respond_to do |format|
      format.html { redirect_to meeting_groups_url, notice: 'Meeting group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting_group
      @meeting_group = MeetingGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meeting_group_params
      params.require(:meeting_group).permit(:name)
    end
end
