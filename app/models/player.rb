# == Schema Information
#
# Table name: players
#
#  id            :integer          not null, primary key
#  first_name    :string(255)      not null
#  last_name     :string(255)      not null
#  bats          :integer          not null
#  throws        :integer          not null
#  pos           :integer          not null
#  jersey_number :integer
#  team_id       :integer          not null
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_players_on_id       (id) UNIQUE
#  index_players_on_team_id  (team_id)
#

class Player < ActiveRecord::Base
  self.primary_key = 'id'
  belongs_to :team
  has_one :batter

  include Scrapable

  BATS = {
    'R' => 0,
    'L' => 1,
    'S' => 2
  }.freeze

  THROWS = {
    'R' => 0,
    'L' => 1
  }.freeze

  POS = {
    'D'  => 0,
    'P' => 1,
    'C'  => 2,
    '1B' => 3,
    '2B' => 4,
    '3B' => 5,
    'SS' => 6,
    'LF' => 7,
    'CF' => 8,
    'RF' => 9,
    'O'  => 10
  }.freeze

  class << self
    def create_or_update(player)
      player.each do |b|
        attr = normarize(b.attributes)
        player = find_or_initialize_by(id: attr[:id])
        player.update!(attr)
      end
    end

    private

    def normarize(attr)
      normarized = {}
      attr.each do |_, v|
        key = v.name.downcase
        v = v.value
        key, v = name_to_first_name(key, v) if key == 'name_display_first_last'
        v = convert_value(key, v)
        normarized[key.to_sym] = v if Player.attribute_names.include? key
      end
      normarized
    end

    def name_to_first_name(k, v)
      v = v.gsub!(/\s.*/, '')
      ['first_name', v]
    end

    def convert_value(k, v)
      case k
      when 'bats'
        return BATS[v]
      when 'pos'
        return POS[v]
      when 'throws'
        return THROWS[v]
      when 'id'
        return v.to_i
      else
        return v
      end
    end
  end
end
