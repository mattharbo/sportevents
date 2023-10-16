class FixturesController < ApplicationController

  before_action :get_all_teams, only: [:edit, :new]
  before_action :get_all_competitions, only: [:edit, :new]
  before_action :set_fixture, only: [:show, :edit, :update, :destroy]

  def index
    @fixtures=Fixture.all.order("id asc")
  end

  def show
  end

  def new
    @fixture=Fixture.new
  end

  def create
    selectedcompetition=Competition.find(params[:fixture][:competition_id])
    selectedhometeam=Team.find(params[:fixture][:hometeam_id])
    selectedawayteam=Team.find(params[:fixture][:awayteam_id])
    Fixture.create(
      competition:selectedcompetition,
      hometeam:selectedhometeam,
      awayteam:selectedawayteam,
      # dateandtime:xxxx,
      finished:false
      )
    redirect_to fixtures_path
  end

  def edit
  end

  def update
    selectedcompetition=Competition.find(params[:fixture][:competition_id])
    selectedhometeam=Team.find(params[:fixture][:hometeam_id])
    selectedawayteam=Team.find(params[:fixture][:awayteam_id])
    @fixture.update(hometeam:selectedhometeam,
      awayteam:selectedawayteam,
      # dateandtime:xxxx,
      scorehome:params[:fixture][:scorehome],
      scoreaway:params[:fixture][:scoreaway],
      finished:params[:finished],
      competition:selectedcompetition
      )
    redirect_to fixtures_path
  end

  def destroy
    @fixture.destroy
    redirect_to fixtures_path
  end

  # ****
  # **** Private function starting from here
  # ****

  private

  def set_fixture
    @fixture = Fixture.find(params[:id])
  end

  def get_all_teams
    @teams=Team.all
  end

  def get_all_competitions
    @competitions=Competition.all
  end

  def fixture_params
    params.require(:fixture).permit(:hometeam, :awayteam, :dateandtime, :scorehome, :scoreaway, :finished, :competition)    
  end

end



