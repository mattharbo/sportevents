class League < ApplicationRecord
	has_many :competitions, dependent: :destroy
end
