# == Schema Information
#
# Table name: batters
#
#  id         :integer          not null, primary key
#  player_id  :integer          not null
#  h          :integer          not null
#  ab         :integer          not null
#  tb         :integer          not null
#  r          :integer          not null
#  b2         :integer          not null
#  b3         :integer          not null
#  hr         :integer          not null
#  rbi        :integer          not null
#  sac        :integer          not null
#  sf         :integer          not null
#  hbp        :integer          not null
#  bb         :integer          not null
#  ibb        :integer          not null
#  so         :integer          not null
#  sb         :integer          not null
#  cs         :integer          not null
#  gidp       :integer          not null
#  np         :integer          not null
#  go         :integer          not null
#  ao         :integer          not null
#  tpa        :integer          not null
#  avg        :float            not null
#  slg        :float            not null
#  ops        :float            not null
#  obp        :float            not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_batters_on_player_id  (player_id) UNIQUE
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
        key = normarize_key(key)
        normarized[key.to_sym] = v.to_i if Batter.
          attribute_names.include? key
      end
      normarized
    end

    def normarize_key(key)
      if key =~ /\s*_sort/
        return key.gsub(/_sort/,'')
      elsif key == 'id'
        return 'player_id'
      end
      key
    end
  end
end
