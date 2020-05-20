require 'open-uri'
require 'nokogiri'
require 'pry'

#make calls to api
class API

    self.fetch_trails
        url = "https://www.trailrunproject.com/directory/8007899/georgia"
        uri = URI(url)
        response = Net::HTTP.get(uri)
        hash = JSON.parse(response)
        #lookup the id tag for trails and replace "trails"
        array_of_trails = hash["trails"]

        array_of_trails.each do |trail_hash| 
            trail_instance = Trail.new
            trail_instance.name = trail_hash[""]  #"idTrail"
            trail_instance.location = trail_hash[""] #"trailLocation"
            trail_instance.length = trail_hash[""] 
            trail_instance.difficulty = trail_hash[""]
            trail_instance.ascent = trail_hash[""]
        end
        binding.pry
    end

end


end

class TrailScraper
    attr_accessor :TrailScraper
    
    def self.scrape_index_page(index_url)


end