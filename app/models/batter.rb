# == Schema Information
#
# Table name: batters
#
#  id            :integer          not null
#  first_name    :string(255)      not null
#  last_name     :string(255)      not null
#  bats          :integer          not null
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

  class << self
    def fetch
      ::Team::TEAM_ID.each do |team_id|
        uri = BASE_URL +
          "components/team/stats/#{team_id}-stats.xml"
        batter = Nokogiri::XML.parse(open(uri)).css('batter')
      end
    end
  end
end
