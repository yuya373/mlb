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

require 'spec_helper'

describe Pitcher do
  pending "add some examples to (or delete) #{__FILE__}"
end
