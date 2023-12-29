class FixturesController < ApplicationController

  before_action :get_all_teams, only: [:edit, :new]
  before_action :get_all_competitions, only: [:edit, :new]
  before_action :set_fixture, only: [:show, :edit, :update, :destroy]

  def index
    @fixtures=Fixture.all.order("dateandtime desc")

    # --- For future needs
    # @fixtures=Fixture.all.group_by { |x| [x.round]}
  end

  def show
  end

  def new
    @fixture=Fixture.new
  end

  def create

    hometeam=select_dropdown[1]
    awayteam=select_dropdown[2]
    year=params[:fixture]["dateandtime(1i)"]
    month=params[:fixture]["dateandtime(2i)"].rjust(2, '0')
    day=params[:fixture]["dateandtime(3i)"].rjust(2, '0')
    hours=params[:fixture]["dateandtime(4i)"]
    minutes=params[:fixture]["dateandtime(5i)"]

    # --- Create instance in DB
    
    select_dropdown
    Fixture.create(
      competition:select_dropdown[0],
      hometeam:hometeam,
      awayteam:awayteam,
      # dateandtime:Time.parse("2023/10/17 06:30"),
      dateandtime:Time.parse(year + "/" + month + "/" + day + " " + hours + ":" + minutes),
      finished:false,
      round:params[:fixture][:round]
      )

      # --- Create trello card

      require 'uri'
      require 'net/http'

      trellodatetime = year + "-" + month + "-" + day + "T" + (hours.to_i-1).to_s + ":" + minutes +":00.000Z"

      uri = URI('https://api.trello.com/1/cards')
      params = {
        :idList => '650176b25abd1588a073fb9e',
        :key => 'a540f1bf835a384aba71ba64bab207d9',
        :token => 'ATTA7061f69e09fa9e5616199f3276f4716f61f1720ddb4fe870bb78ed54d59613a5E0D4F925',
        :name => "⚽️ Ligue 1 • #{hometeam.shortname} v. #{awayteam.shortname}",
        :desc => "Description coming soon",
        :due => trellodatetime
      }

      res = Net::HTTP.post_form(uri,params)
      @toprint = res.body if res.is_a?(Net::HTTPSuccess)

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