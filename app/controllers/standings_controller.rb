class StandingsController < ApplicationController

	def index
		@standings=Standing.all
	end

end
