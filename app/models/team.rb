# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  team_id    :integer          not null
#  league_id  :integer          not null
#  name       :string(255)      not null
#  abbrev     :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Team < ActiveRecord::Base
  include Scrapable
  TEAM_ID = ( (108..121).to_a + (133..147).to_a + [158] ).freeze
  class << self
    def fetch
      TEAM_ID.each do |team_id|
        uri = Scrapable::BASE_URL +
          "components/team/stats/#{team_id}-stats.xml"
        content = Nokogiri::XML.parse(open(uri)).css('TeamStats')
        attr = normarize( content.first.attributes )
        game_id = attr.delete(:game_id)
        team = find_or_create_new(attr)
      end
    end

    private

    def find_or_create_new(attr)
      find_or_create_by(team_id: attr[:team_id]) do |team|
        team.team_id = attr[:team_id]
        team.league_id = attr[:league_id]
        team.name = attr[:name]
        team.abbrev = attr[:abbrev]
      end
    end

    def normarize(attr)
      normarized = {}
      attr.each do |_, v|
        key = v.name
        key.gsub!(/team_/, '') unless key == 'team_id'
        v = v.value
        normarized[key.to_sym] = v
      end
      normarized
    end
  end
end
