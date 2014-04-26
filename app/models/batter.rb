# == Schema Information
#
# Table name: batters
#
#  id            :integer          not null, primary key
#  first_name    :string(255)      not null
#  last_name     :string(255)      not null
#  bats          :integer          not null
#  throws        :integer          not null
#  pos           :integer          not null
#  jersey_number :integer          not null
#  team_id       :integer          not null
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_batters_on_id       (id) UNIQUE
#  index_batters_on_team_id  (team_id)
#

class Batter < ActiveRecord::Base
  include Scrapable
  belongs_to :player

  class << self
    def create_or_update(batter)
      batter.each do |b|
        attr = normarize(b.attributes)
        stats = find_or_initialize_by(player_id: attr[:player_id])
        stats.update!(attr)
      end
    end

    private

    def normarize(attr)
      normarized = {}
      attr.each do |_, v|
        key = v.name.downcase
        v = v.value
        key = 'player_' + key if key == "id"
        normarized[key.to_sym] = v.to_i if Batter.
          attribute_names.include? key
      end
      normarized
    end
  end
end
