module Memorable

    module ClassMethods
        
        def count
            self.all.count
        end

        def reset
            self.all.clear
        end

        # def self.find_by_id(id)
        #     self.all.detect {|item| item.id == id}
        # end

        # def self.create_by_id(id)
        #     inst = self.new(id)
        #     inst.save
        #     inst
        # end

        # def self.find_or_create_by_id(id)
        #     find_by_id(id) || create(id)
        # end
          
    end


    module InstanceMethods

        def save
            self.class.all << self
        end

    end

end