namespace :scrape do
  require 'open-uri'
  BASE_URL = 'http://gd2.mlb.com/'
  TEAM_ID = ((108..121).to_a + (133..147).to_a + [158]).freeze

  desc 'get all'
  task all: ['team:get', 'batter:get', 'pitcher:get']

  desc 'get player'
  task player: ['batter:get', 'pitcher:get']

  namespace :team do
    desc 'get Team'
    task get: :environment do
      get_doc do |team|
        Team.create_or_update(team)
      end
    end
  end

  namespace :batter do
    desc 'get batter'
    task get: :environment do
      get_doc do |doc|
        batter = doc.css('batter')
        Player.create_or_update(batter)
        Batter.create_or_update(batter)
      end
    end
  end

  namespace :pitcher do
    desc 'get pitcher'
    task get: :environment do
      get_doc do |doc|
        pitcher = doc.css('pitcher')
        Player.create_or_update(pitcher)
        Pitcher.create_or_update(pitcher)
      end
    end
  end

  def get_doc(&block)
    TEAM_ID.each do |team_id|
      uri = BASE_URL +
        "components/team/stats/year_2014/#{team_id}-stats.xml"
      doc = Nokogiri::XML.parse(open(uri)).css('TeamStats')
      yield doc
    end
  end
end
