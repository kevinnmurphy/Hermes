#interacts with user
#puts and gets statements go here
#controls flow

##TODO  
#get zip input
#use lat and lon to make zip
class CLI

    @@Base_url = ""

    def run
        welcome
        #get input
        
        
        API.fetch_trails
        list_trails
        menu
    end

    def welcome
        puts "Welcome to the Trail Runner App!"
    end

    # def get_input(lat: = @lat, lon: = @lon)
    #     get_lat_input(lat: = @lat)
    #     get_lon_input(lon: = @lat)
    #     @lat = get_lat_input
    #     @lon = get_lon_input
    # end

    # def is_number?(string)
    #     true if Float(string) rescue false
    # end

    def get_lat_input
        puts "Latitude please: " 
        input = gets.chomp
        if input.is_a?(Float) #check for digit count?
            #@lat = input.to_f
            puts "#{input}"
        else  
            puts "Please enter a valid input"
            get_lat_input 
        end 
        #lat
    end 

    def get_lon_input
        puts "Longitude please: " 
        input = gets.chomp
        if input.is_a?(Float)
            #@lon = input.to_f
            puts "#{input}"
        else  
            puts "Please enter a valid input"
            get_lon_input 
        end 
        #lon
    end 

    def list_trails
        @trails = Trail.all
        @trails.each.with_index(1) do |trail, i|
            puts "#{i}. #{trail.name} - #{trail.location}"
        end
    end

    def display_trail_info(input)
        trail_index = @trails[input.to_i-1]
        puts "Trail: #{trail_index.name} - City: #{trail_index.location} - Dificulty: #{trail_index.difficulty}"
        puts "Length: #{trail_index.length} mi - Ascent: #{trail_index.ascent} ft - Descent: #{trail_index.descent} ft"
        puts "\"#{trail_index.summary}\""
    end

    def sort_by_param_and_name(items)
        @trails = Trail.all
        #@trails.sort_by {|k,v| v[0]}
        items.sort_by { |i| [i[:length], i[:name]] }

        #Trail.all.sort{|a,b| a.name <=> b.name}
    end

    def menu
        puts "Enter the trail number you would like to know more about, or type \'list\' to view trails, or type \'exit\'."
        input = nil
        while input != "exit"
            #get input
            input = gets.strip.downcase
            input_limit = Trail.all.length
            #validate
            if input.to_i.between?(1, input_limit)
                #list available trail info
                display_trail_info(input)
            elsif input == "list"
                puts "Nearby Trails:"
                list_trails
            elsif input == "sort"
                sort_by_param_and_name(@trails)
                #sort trails by length
            elsif input == "exit"
                goodbye
            else
                puts "Not sure what you want, type list or exit."
                # recursion
                #menu
            end
        end
    end

    def goodbye
        puts "Come back for more trail info!"
    end
   
end