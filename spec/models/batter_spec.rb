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

require 'spec_helper'

describe Batter do
  describe '#normarize' do
    url = 'http://gd2.mlb.com/components/team/stats/114-stats.xml'
    let(:attr){
      VCR.use_cassette 'team-stats' do
        Nokogiri::XML.parse(open(url)).css('batter').first.attributes
      end
    }

    it do
      Batter.attribute_names.map(&:to_sym).
        reject{|attr| attr == :created_at || attr == :updated_at}.each do |e|
        expect( Batter.send(:normarize, attr) ).to include e
      end
    end
  end
end
