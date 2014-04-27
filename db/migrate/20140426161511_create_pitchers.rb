class CreatePitchers < ActiveRecord::Migration
  def change
    create_table :pitchers do |t|
      t.belongs_to :player, null: false
      t.float :ip, null: false
      t.integer :er, null: false
      t.float :era, null: false
      t.integer :w, null: false
      t.integer :l, null: false
      t.integer :h, null: false
      t.integer :r, null: false
      t.integer :hr, null: false
      t.integer :hb, null: false
      t.integer :bb, null: false
      t.integer :ibb, null: false
      t.integer :so, null: false
      t.integer :wp, null: false
      t.integer :g, null: false
      t.integer :gs, null: false
      t.integer :cg, null: false
      t.integer :gf, null: false
      t.integer :sho, null: false
      t.integer :sv, null: false
      t.integer :bsv, null: false
      t.integer :svo, null: false
      t.integer :gidp, null: false
      t.integer :np, null: false
      t.float :avg, null: false
      t.float :slg, null: false
      t.float :whip, null: false
      t.float :pct, null: false
      t.integer :ab, null: false
      t.integer :sf, null: false
      t.integer :sac, null: false
      t.integer :ao, null: false
      t.integer :go, null: false
      t.integer :bk, null: false
      t.integer :hld, null: false
      t.integer :tpa, null: false
      t.integer :po, null: false
      t.integer :a, null: false
      t.integer :e, null: false

      t.timestamps
    end
    add_index :pitchers, :player_id, unique: true
  end
end
