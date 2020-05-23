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

    def self.all_by_difficulty(dif)
        self.all.select{|trail| trail.difficulty.downcase == dif.downcase}
    end

    # def self.create_from_collection(trails_array)
    #     trails_array.each {|hash| self.new(hash)}
    # end

    # def add_trail_attributes(trail_attributes_hash)
    #     trail_attributes_hash.each_pair {|key, value| self.send("#{key}=", value)}
    # end

    # def self.scraper    
    #     trails = []

    #     trails << self.scrape_trails
    # end

end