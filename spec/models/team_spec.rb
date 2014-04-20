# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
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

require 'spec_helper'
require 'open-uri'

describe Team do
  describe 'normarized' do
    url = 'http://gd2.mlb.com/components/team/stats/114-stats.xml'
    let(:attr){
      VCR.use_cassette 'team-stats' do
        Nokogiri::XML.parse(open(url)).css('TeamStats').first.attributes
      end
    }

    it do
      Team.attribute_names.map(&:to_sym).
        reject{|a| a == :created_at || a == :updated_at}.each do |e|
        expect(Team.send(:normarize, attr)).to include e
      end
    end
  end
end
