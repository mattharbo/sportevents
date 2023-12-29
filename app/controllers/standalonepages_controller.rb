class StandalonepagesController < ApplicationController

	def homepage
		get_team("Paris") # Function in application_controller
	end

end
