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
  self.primary_key = 'id'

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
    'P'  => 1,
    'C'  => 2,
    '1B' => 3,
    '2B' => 4,
    '3B' => 5,
    'SS' => 6,
    'LF' => 7,
    'CF' => 8,
    'RF' => 9
  }.freeze

  class << self
    def fetch
      ::Team::TEAM_ID.each do |team_id|
        uri = Scrapable::BASE_URL +
          "components/team/stats/#{team_id}-stats.xml"
        row_batter = Nokogiri::XML.parse(open(uri)).css('batter')
        row_batter.each do |b|
          attr = normarize(b.attributes)
          batter = find_or_initialize_by(id: attr[:id])
          batter.update!(attr)
        end
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
        normarized[key.to_sym] = v if Batter.attribute_names.include? key
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
