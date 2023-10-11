class CreateCompetitions < ActiveRecord::Migration[7.0]
  def change
    create_table :competitions do |t|
      t.references :league, null: false, foreign_key: true
      t.references :season, null: false, foreign_key: true

      t.timestamps
    end
  end
end
