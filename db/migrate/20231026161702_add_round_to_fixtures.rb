class AddRoundToFixtures < ActiveRecord::Migration[7.0]
  def change
    add_column :fixtures, :round, :string
  end
end
