# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null
#  league_id  :integer          not null
#  name       :string(255)      not null
#  abbrev     :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_teams_on_id  (id) UNIQUE
#

class Team < ActiveRecord::Base
  include Scrapable
  TEAM_ID = ((108..121).to_a + (133..147).to_a + [158]).freeze
  class << self
    def fetch
      TEAM_ID.each do |team_id|
        uri = Scrapable::BASE_URL +
          "components/team/stats/#{team_id}-stats.xml"
        content = Nokogiri::XML.parse(open(uri)).css('TeamStats')
        attr = normarize(content.first.attributes)
        team = find_or_initialize_by(id: attr[:id])
        team.update!(attr)
      end
    end

    private

    def normarize(attr)
      normarized = {}
      attr.each do |_, v|
        key = v.name.gsub(/team_/, '')
        v = v.value
        v = v.to_i if key == 'id'
        normarized[key.to_sym] = v if Team.attribute_names.include? key
      end
      normarized
    end
  end
end
