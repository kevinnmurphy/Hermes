require_relative '../concerns/memorable'

class Trail
    attr_accessor :id, :name, :location, :length, :difficulty, :ascent, :descent, :summary, :url
    extend Memorable::ClassMethods
    include Memorable::InstanceMethods

    @@all = []

    def initialize(attributes)
        attributes.each {|key, value| self.send(("#{key}="), value)}
    end
    
    def self.all
        @@all
    end

    def self.exists?(index)
        (1..all.length).include?(index.to_i)
    end

    def self.create_by_id(id)
        trail = Trail.new(id)
        trail.save
        trail
    end

    def self.find_by_id(id)
        all.find{|trail| trail.id == id}
    end
      
    def self.find_or_create_by_id(id)
        find_by_id(id) || create_by_id(id)
    end

    def list_trails_by_name
        puts "Please enter the name of a trail:"
        input = gets.chomp
        
        if trail = Trail.find_by_name(input)
          sorted_trails = artist.trails.sort_by {|trail| trail.name}
          sorted_trails.each.with_index {|trail, index| puts "#{index + 1}. #{trail.name}"}
        end
      end

    def self.all_by_difficulty(difficulty)
        self.all.select{|trail| trail.difficulty.downcase == difficulty.downcase}
    end

    # def add_trail_attributes(trail_attributes_hash)
    #     trail_attributes_hash.each_pair {|key, value| self.send("#{key}=", value)}
    # end

end