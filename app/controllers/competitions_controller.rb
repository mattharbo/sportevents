class CompetitionsController < ApplicationController

  before_action :get_all_leagues_and_seasons, only: [:edit, :new]
  before_action :set_competition, only: [:show, :edit, :update, :destroy]
  
  def index
    @competitions=Competition.all
  end

  def new
    @competition=Competition.new
  end

  def edit
  end

  def create
    target_season=Season.find(params[:competition][:season_id])
    target_league=League.find(params[:competition][:league_id])
    Competition.create(season:target_season, league:target_league)
    redirect_to competitions_path
  end

  def update
    target_season=Season.find(params[:competition][:season_id])
    target_league=League.find(params[:competition][:league_id])
    @competition.update(season:target_season, league:target_league)
    redirect_to competitions_path
  end

  def destroy
    @competition.destroy
    redirect_to competitions_path
  end

# ****
# **** Private function starting from here
# ****

  private

  def get_all_leagues_and_seasons
    @leagues=League.all
    @seasons=Season.all
  end

  def set_competition
    @competition = Competition.find(params[:id])
  end

  def competition_params
    params.require(:competition).permit(:league, :season)    
  end
  
end
