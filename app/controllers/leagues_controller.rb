class LeaguesController < ApplicationController
  before_action :set_league, only: [:show, :edit, :update, :destroy]

  # GET /leagues
  # GET /leagues.json
  def index
    @leagues = League.all
    @posts = Post.last(6)
    @games = (Game.where("date_time >= ?", Date.today).order("date_time ASC").first(13)).select do |game|
    @teams_need_admin = Team.where(team_admin_id: nil)
      if game.home_team_score.nil?
        game
      end
    end
    if params[:approved] == "false"
      @teamadmins = TeamAdmin.find_by_approved(false)
    else
      @teamadmins = TeamAdmin.all
    end
  end

  def activate
    teamadmin = TeamAdmin.find(params[:id])
    teamadmin.update_attribute(:approved, true)
    Team.find(params[:team]).update(team_admin_id: teamadmin.id)
    redirect_to "/"
  end

  def deactivate
    teamadmin = TeamAdmin.find(params[:id])
    teamadmin.destroy!
    redirect_to "/"
  end
  # GET /leagues/1
  # GET /leagues/1.json
  # def show
  # end

  # GET /leagues/new
  # def new
  #   @league = League.new
  # end

  # GET /leagues/1/edit
  # def edit
  # end

  # POST /leagues
  # POST /leagues.json
  # def create
  #   @league = League.new(league_params)

  #   respond_to do |format|
  #     if @league.save
  #       format.html { redirect_to @league, notice: 'League was successfully created.' }
  #       format.json { render :show, status: :created, location: @league }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @league.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /leagues/1
  # PATCH/PUT /leagues/1.json
  # def update
  #   respond_to do |format|
  #     if @league.update(league_params)
  #       format.html { redirect_to @league, notice: 'League was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @league }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @league.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /leagues/1
  # DELETE /leagues/1.json
  # def destroy
  #   @league.destroy
  #   respond_to do |format|
  #     format.html { redirect_to leagues_url, notice: 'League was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  # private
    # Use callbacks to share common setup or constraints between actions.
    # def set_league
    #   @league = League.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def league_params
    #   params.require(:league).permit(:league_admin_id, :name, :sport)
    # end
end
