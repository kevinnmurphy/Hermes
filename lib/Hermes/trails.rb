require_relative '../concerns/memorable'

class Trail
    attr_accessor :id, :name, :location, :length, :difficulty, :ascent, :descent, :summary, :url
    extend Memorable::ClassMethods
    include Memorable::InstanceMethods

    @@all = []

    def initialize(attributes)
        attributes.each {|key, value| self.send(("#{key}="), value)}
        save
    end
    
    def self.all
        @@all
    end

    def self.create_from_collection(trails_array)
        trails_array.each {|hash| self.new(hash)}
    end

    def add_trail_attributes(trail_attributes_hash)
        trail_attributes_hash.each_pair {|key, value| self.send("#{key}=", value)}
    end

    # def self.trails

    #     trail_1 = self.new
    #     trail_1.id = "7011192"
    #     trail_1.name = "Boulder Skyline Traverse"
    #     trail_1.location = "Boulder, Colorado"
    #     trail_1.length = "16.3"
    #     trail_1.difficulty = "Hard" #"black"
    #     trail_1.ascent = "5409"
    #     trail_1.descent = "-5492"
    #     trail_1.summary = "The classic long mountain route in Boulder."
    #     trail_1.url = "5.5"

    #     trail_2 = self.new
    #     trail_1.id = "7004226"
    #     trail_2.name = "Sunshine Lion's Lair Loop"
    #     trail_2.location = "Boulder, Colorado"
    #     trail_2.length = "5.3"
    #     trail_2.difficulty = "Intermediate" #"blueBlack"
    #     trail_2.ascent = "1261"
    #     trail_2.descent = "-1282"
    #     trail_2.summary = "Great Mount Sanitas views are the reward for this gentler loop in Sunshine Canyon."
    #     trail_2.url = "https:\/\/www.trailrunproject.com\/trail\/7004226\/sunshine-lions-lair-loop"

    #     [trail_1, trail_2]
    # end

    def self.scraper    
        trails = []

        trails << self.scrape_trails
    end

    def self.scrape_trails
        doc = Nokogiri::HTML(open("https:woot.com"))
    end
end