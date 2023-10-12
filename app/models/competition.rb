class Competition < ApplicationRecord
  belongs_to :league
  belongs_to :season
end