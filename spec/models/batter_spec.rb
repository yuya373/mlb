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
