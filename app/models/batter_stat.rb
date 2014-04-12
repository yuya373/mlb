class BatterStat < ActiveRecord::Base
  include Scrapable
  belongs_to :batter

  class << self
    def fetch
      Team.pluck(:id).each do |team_id|
        uri = Scrapable::BASE_URL +
          "components/team/stats/#{team_id}-stats.xml"
        batter = Nokogiri::XML.parse(open(uri)).css('batter')
        batter.each do |b|
          attr = normarize(b.attributes)
          stats = find_or_initialize_by(batter_id: attr[:batter_id])
          stats.update!(attr)
        end
      end
    end

    private

    def normarize(attr)
      normarized = {}
      attr.each do |_, v|
        key = v.name.downcase
        v = v.value
        key = 'batter_' + key if key == "id"
        normarized[key.to_sym] = v.to_i if BatterStats.
          attribute_names.include? key
      end
      normarized
    end
  end
end
