class AddGameplayedToStandings < ActiveRecord::Migration[7.0]
  def change
    add_column :standings, :played, :integer
  end
end
