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

require 'spec_helper'

describe Team do
  pending "add some examples to (or delete) #{__FILE__}"
end
