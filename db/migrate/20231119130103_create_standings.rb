class CreateStandings < ActiveRecord::Migration[7.0]
  def change
    create_table :standings do |t|
      t.references :competition, null: false, foreign_key: true
      t.integer :round
      t.references :team, null: false, foreign_key: true
      t.integer :rank
      t.integer :points

      t.timestamps
    end
  end
end
