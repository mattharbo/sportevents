class Season < ApplicationRecord
	has_many :competitions, dependent: :destroy
end
