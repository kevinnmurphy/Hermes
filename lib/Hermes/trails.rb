require_relative '../concerns/memorable'

class Trail
    attr_accessor :id, :name, :location, :length, :difficulty, :ascent, :descent, :summary, :url
    extend Memorable::ClassMethods
    include Memorable::InstanceMethods

    @@all = []
    @@sorted = []

    def initialize(attributes)
        attributes.each {|key, value| self.send(("#{key}="), value)}
    end
    
    def self.all
        @@all
    end

    def self.sorted
        @@sorted
    end

    def self.sorted_clear
        @@sorted.clear
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
        self.all.find{|trail| trail.id == id}
    end
      
    def self.find_or_create_by_id(id)
        find_by_id(id) || create_by_id(id)
    end

    def self.all_by_difficulty(difficulty)
        self.all.select{|trail| trail.difficulty.downcase == difficulty.downcase}
    end

end