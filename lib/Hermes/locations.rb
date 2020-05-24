require_relative '../concerns/memorable'

class Location
    attr_accessor :ip, :auto_latitude, :auto_longitude
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

end