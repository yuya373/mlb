# == Schema Information
#
# Table name: pitchers
#
#  id         :integer          not null, primary key
#  player_id  :integer          not null
#  ip         :float            not null
#  er         :integer          not null
#  era        :float            not null
#  w          :integer          not null
#  l          :integer          not null
#  h          :integer          not null
#  r          :integer          not null
#  hr         :integer          not null
#  hb         :integer          not null
#  bb         :integer          not null
#  ibb        :integer          not null
#  so         :integer          not null
#  wp         :integer          not null
#  g          :integer          not null
#  gs         :integer          not null
#  cg         :integer          not null
#  gf         :integer          not null
#  sho        :integer          not null
#  sv         :integer          not null
#  bsv        :integer          not null
#  svo        :integer          not null
#  gidp       :integer          not null
#  np         :integer          not null
#  avg        :float            not null
#  slg        :float            not null
#  whip       :float            not null
#  pct        :float            not null
#  ab         :integer          not null
#  sf         :integer          not null
#  sac        :integer          not null
#  ao         :integer          not null
#  go         :integer          not null
#  bk         :integer          not null
#  hld        :integer          not null
#  tpa        :integer          not null
#  po         :integer          not null
#  a          :integer          not null
#  e          :integer          not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_pitchers_on_player_id  (player_id) UNIQUE
#

class Pitcher < ActiveRecord::Base
  belongs_to :player

  class << self
    def create_or_update(pitcher)
      pitcher.each do |p|
        attr = normarize(p.attributes)
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
        normarized[key.to_sym] = v.to_i if Pitcher.
          attribute_names.include? key
      end
      normarized
    end

    def normarize_key(key)
      if key =~ /\s*_sort/
        return key.gsub(/_sort/, '')
      elsif key == 'id'
        return 'player_id'
      end
      key
    end
  end

  scope :era_sort, ->{
    order(era: :desc)
  }
end
