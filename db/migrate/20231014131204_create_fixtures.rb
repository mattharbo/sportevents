class CreateFixtures < ActiveRecord::Migration[7.0]
  def change
    create_table :fixtures do |t|
      t.references :hometeam, null: false
      t.references :awayteam, null: false
      t.timestamp :dateandtime
      t.integer :scorehome
      t.integer :scoreaway
      t.boolean :finished

      t.timestamps
    end
    add_foreign_key :fixtures, :teams, column: :hometeam_id, primary_key: :id
    add_foreign_key :fixtures, :teams, column: :awayteam_id, primary_key: :id
  end
end
