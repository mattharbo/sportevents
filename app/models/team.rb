class Team < ApplicationRecord
	has_many :hometeam_fixtures, :class_name => "Fixture", :foreign_key => "hometeam_id"
	has_many :awayteam_fixtures, :class_name => "Fixture", :foreign_key => "awayteam_id"
end
