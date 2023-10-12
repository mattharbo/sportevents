class SeasonsController < ApplicationController

	before_action :set_season, only: [:show, :edit, :update, :destroy]

	def index
		@seasons=Season.all
	end

	def new
		@season=Season.new
	end

	def edit
	end

	def show	
	end

	def create
		Season.create(season_params)
		redirect_to seasons_path
	end

	def update
		@season.update(season_params)
		redirect_to seasons_path
	end

	def destroy
		@season.destroy
		flash[:success] = "The to-do item was successfully destroyed."
		redirect_to seasons_path
	end

# ****
# **** Private function starting from here
# ****

	private

	def set_season
		@season = Season.find(params[:id])
	end

	def season_params
		params.require(:season).permit(:startyear)		
	end

end