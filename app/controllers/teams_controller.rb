class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_team_to_manager, only: [:edit, :update]
  before_action :authenticate_team_admin!, only: [:edit, :update]
  before_action :authenticate_league_admin, only: [:delete]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.select{|team| !team.team_admin_id.nil? }
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @posts = Post.filter_by_team(params[:id])
    @games = Game.filter_by_team(params[:id])
    @reviewabletrades = Trade.where(accepting_team: @team.id).where(accepted: nil)
    @proposedtrades = Trade.where(proposing_team: @team.id).where(accepted: nil)
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit

  end

  def league_team_edit

  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:team_admin_id, :name, :league_id, :city, :mascot, :primary_color, :secondary_color)
    end
end
