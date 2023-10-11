class League < ApplicationRecord
	has_many :leagues, dependent: :destroy
end
