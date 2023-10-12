class LeaguesController < ApplicationController

	before_action :set_league, only: [:show, :edit, :update, :destroy]

	def index
		@leagues=League.all.order("id asc")
	end

	def new
		@league=League.new
	end

	def edit
	end

	def create
		League.create(league_params)
		redirect_to leagues_path
	end

	def update
		@league.update(league_params)
		redirect_to leagues_path
	end

	def destroy
		@league.destroy
		redirect_to leagues_path
	end

# ****
# **** Private function starting from here
# ****

	private

	def set_league
		@league = League.find(params[:id])
	end

	def league_params
		params.require(:league).permit(:name, :desc)		
	end

end