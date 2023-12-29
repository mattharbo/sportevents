class ApplicationController < ActionController::Base

	def get_team(teamname)

		@teamfrombdd = Team.where("name like ?", "%#{teamname.split.last}%")

		# To handle "Stade Rennais" case which doesn't match with the team name
		@teamfrombdd.blank? ? @teamfrombdd = Team.where("city like ?", "%#{teamname.split.last}%") : @teamfrombdd

		return @teamfrombdd
	end

end

