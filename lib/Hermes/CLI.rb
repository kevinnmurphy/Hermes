#interacts with user
#puts and gets statements go here
#controls flow

##TODO  
#get zip input
#use lat and lon to make zip
class Hermes::CLI

    @@Base_url = ""

    def run
        puts "Welcome to the Trail Runner App!"
        #get input
        list_trails
        menu
        goodbye

        #get_lat_input
        #get_lon_input
        #get_trails
        #make_trails
        #add_attributes_to_trails
        #display_trails
    end

    def list_trails
        puts "Nearby Trails:"
        puts <<-DOC.gsub /^\s*/, ''
        1. Boulder Skyline Traverse
        2. Bear Peak Out and Back
        3. Sunshine Lion's Lair Loop
        DOC
    end

    def menu
        puts "Enter the trail number you would like to know more about, or type list to view trails, or type exit "
        input = nil
        while input != "exit"
            input = gets.strip.downcase
            case input
            when "1"
                puts "trail 1"
            when "2"
                puts "trail 2"
            when "list"
                list_trails
            else
                puts "Not sure what you want, type list or exit"
            end
        end
    end

    def goodbye
        puts "Come back for more trail info!"
    end

    # def make_trails
    #     trails_array = Scraper.scrape_index_page(@@Base_url + "")
    #     Trail.create_from_collection(trails_array)
    # end

    # def add_attributes_to_trails
    #     Trail.all.each do |trail|
    #         attributes = Scraper.scrape_data_page(@@Base_url + "")
    #         trail.add_trail_attributes(attributes)
    #     end
    # end

    # def is_number?(string)
    #     true if Float(string) rescue false
    # end

    def get_lat_input 
        puts "Latitude please: " 
        input = gets.chomp
        if input.is_a?(Float) #check for digit count?
            lat = input.to_f
        else  
            puts "Please enter a valid input"
            get_lat_input 
        end 
        lat
    end 

    def get_lon_input 
        puts "Longitude please: " 
        input = gets.chomp
        if input.is_a?(Float)
            lon = input.to_f
        else  
            puts "Please enter a valid input"
            get_lon_input 
        end 
        lon
    end 

    # def get_trail_search
    #     trail_results = Hermes::API.trail_results
    
    #     puts "\nFor more information, please select a trail from this list."
    
    #     list_results(trail_results)
    
    #     lat = get_lat_input
    #     lon = get_lon_input

    # end

    # def display_trails
    #     Hermes::Trail.all.each do |trail|
    #         puts "#{trail.name}"
    #         puts "#{trail.location}"
    #         puts "#{trail.length} mi"
    #         puts "#{trail.difficulty}"
    #         puts "#{trail.ascent} ft"
    #     end
    # end

end