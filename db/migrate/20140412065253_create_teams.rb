class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :team_id , null: false
      t.integer :league_id, null: false
      t.string :name     , null: false
      t.string :abbrev   , null: false
      t.timestamps
    end
  end
end
