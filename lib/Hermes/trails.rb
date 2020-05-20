class Trail
    attr_accessor :name, :location, :length, :difficulty, :ascent

    @@all = []

    def initialize(trails_hash)
        trail_hash.each_pair {|key, value| self.send("#{key}=", value)}
    
        save
    end
    
    def self.all
        @@all
    end

    def save
        self.all << self
    end

    def reset
        self.all.clear
    end

    def self.create_from_collection(trails_array)
        trails_array.each {|hash| self.new(hash)}
    end

    def add_trail_attributes(trail_attributes_hash)
        trail_attributes_hash.each_pair {|key, value| self.send("#{key}=", value)}
    end


end