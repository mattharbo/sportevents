class FixturesController < ApplicationController

  before_action :get_all_teams, only: [:edit, :new]
  before_action :get_all_competitions, only: [:edit, :new]
  before_action :set_fixture, only: [:show, :edit, :update, :destroy]

  def index
    @fixtures=Fixture.all.order("dateandtime desc")
  end

  def show
  end

  def new
    @fixture=Fixture.new
  end

  def create
    
    select_dropdown
    Fixture.create(
      competition:select_dropdown[0],
      hometeam:select_dropdown[1],
      awayteam:select_dropdown[2],

      # dateandtime:Time.parse("2023/10/17 06:30"),
      dateandtime:Time.parse(
        # => year YYYY
        params[:fixture]["dateandtime(1i)"] +
        "/" +
        # => month MM
        params[:fixture]["dateandtime(2i)"] +
        "/" +
        # => day DD
        params[:fixture]["dateandtime(3i)"] +
        " " +
        # => hour HH
        params[:fixture]["dateandtime(4i)"] +
        ":" +
        # minutes MM
        params[:fixture]["dateandtime(5i)"]),
      
      finished:false,
      round:params[:fixture][:round]
      )
    redirect_to fixtures_path
  end

  def edit
  end

  def update
    select_dropdown
    @fixture.update(hometeam:select_dropdown[1],
      awayteam:select_dropdown[2],
      # dateandtime:xxxx,
      scorehome:params[:fixture][:scorehome],
      scoreaway:params[:fixture][:scoreaway],
      finished:params[:finished],
      dateandtime:Time.parse(
        params[:fixture]["dateandtime(1i)"] +
        "/" +
        params[:fixture]["dateandtime(2i)"] +
        "/" +
        params[:fixture]["dateandtime(3i)"] +
        " " +
        params[:fixture]["dateandtime(4i)"] +
        ":" +
        params[:fixture]["dateandtime(5i)"]),
      competition:select_dropdown[0],
      round:params[:fixture][:round]
      )
    redirect_to fixtures_path
  end

  def destroy
    @fixture.destroy
    redirect_to fixtures_path
  end

  # ****
  # **** Private functions starting from here
  # ****

  private

  def select_dropdown
    selectedcompetition=Competition.find(params[:fixture][:competition_id])
    selectedhometeam=Team.find(params[:fixture][:hometeam_id])
    selectedawayteam=Team.find(params[:fixture][:awayteam_id])
    return selectedcompetition, selectedhometeam, selectedawayteam
  end

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
    params.require(:fixture).permit(:hometeam, :awayteam, :dateandtime, :scorehome, :scoreaway, :finished, :competition, :round)    
  end

end