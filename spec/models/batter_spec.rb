# == Schema Information
#
# Table name: batters
#
#  id         :integer          not null
#  first_name :string(255)      not null
#  last_name  :string(255)      not null
#  bats       :integer          not null
#  pos        :integer          not null
#  number     :integer          not null
#  team_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_batters_on_id       (id) UNIQUE
#  index_batters_on_team_id  (team_id)
#

require 'spec_helper'

describe Batter do
  pending "add some examples to (or delete) #{__FILE__}"
end
