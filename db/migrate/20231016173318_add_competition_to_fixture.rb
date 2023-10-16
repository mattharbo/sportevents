class AddCompetitionToFixture < ActiveRecord::Migration[7.0]
  def change
    add_reference :fixtures, :competition, foreign_key: true
  end
end
