class TeamsController < ApplicationController

  before_action :set_team, only: [:show, :edit, :update, :destroy]

  def index
    @teams=Team.all.order("id asc")
  end

  def new
    @team=Team.new
  end

  def edit
  end

  def create
    Team.create(team_params)
    redirect_to teams_path
  end

  def update
    @team.update(team_params)
    redirect_to teams_path
  end

  def destroy
    @team.destroy
    redirect_to teams_path
  end

# ****
# **** Private function starting from here
# ****

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :shortname, :city)    
  end

end
