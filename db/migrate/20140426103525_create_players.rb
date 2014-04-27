class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players , id: false do |t|
      t.integer :id, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.integer :bats, limit: 1, null: false
      t.integer :throws, limit: 1, null: false
      t.integer :pos, limit: 1, null: false
      t.integer :jersey_number
      t.belongs_to :team, null: false
      t.timestamps
    end

    add_index :players, :team_id
    add_index :players, :id, unique: true
  end
end
