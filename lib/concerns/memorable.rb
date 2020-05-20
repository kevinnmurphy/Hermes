module Memorable

    module ClassMethods
        def count
            self.all.count
        end
    end

    
    module InstanceMethods
        def save
            self.class.all << self
        end
    end

end