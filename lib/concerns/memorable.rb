module Memorable

    module ClassMethods
        
        def count
            self.all.count
        end

        def reset
            self.all.clear
        end

        def self.create_by_id
            trail = Trail.new(id)
            trail.save
            trail
        end

    end


    module InstanceMethods

        def save
            self.class.all << self
        end

        def find_by_id(id)
            self.all.detect {|trail| trail.id == id}
        end
          
        def find_or_create_by_id(id)
            find_by_id(id) || create(id)
        end

    end

end