class Season < ApplicationRecord
	has_many :seasons, dependent: :destroy
end
