#interacts with user
#puts and gets statements go here
#controls flow

##TODO  
#get zip input
#use lat and lon to make zip
class CLI

    @@Base_url = ""

    def run
        greeting        
        #API.fetch_trails
        #list_trails
        menu
    end

    def greeting
        puts "Welcome to the Trail Runner App!"
    end

    def menu
            #get input
            input = nil
            # lat = get_lat_input
            # lon = get_lon_input
            lat = 40.0274 #boulder, co
            lon = 105.2519
            #lat = 34.1065 #sugar hill, ga
            #lon = 84.0335 #convert input to negative for US
            API.fetch_trails(lat, lon)
            list_trails
        
        while input != "exit"

            puts "Enter \'nearby\' to view nearby trails, \'list\' to view nearby trails, or type \'search\' to search trails, or type \'exit\'."
            input = nil
            input = gets.strip.downcase
            input_limit = Trail.all.length
            #validate
            puts "Or enter the trail number you would like to know more about."
            if input.to_i.between?(1, input_limit)
                #list available trail info
                # display_trail_info(input)
                # get_trail(input)
                trail_index = @trails[input.to_i-1]
                puts "Trail: #{trail_index.name} - City: #{trail_index.location} - Dificulty: #{trail_index.difficulty}"
                puts "Length: #{trail_index.length} mi - Ascent: #{trail_index.ascent} ft - Descent: #{trail_index.descent} ft"
                puts "\"#{trail_index.summary}\""
            elsif input == "list"
                puts "Nearby Trails:"
                list_trails 
            elsif input == "search"
                search_by_difficulty
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

    def get_location(lat, lon)
        API.fetch_trails(lat, lon)
    end

    def validate_cords(coord)
        valid_beginning = (coord.to_f.to_s.split(".")[0]).to_s.length
        valid_ending = (coord.to_f.to_s.split(".")[1]).to_s.length
        if valid_beginning.between?(2, 3) && valid_ending == 4
            coord
        else
            puts "Invalid entry, please use this format \'12.345\'"
        end
    end

    def get_lat_input
        puts "Latitude please: ex. 40.0274" 
        input = gets.chomp
        input.to_f if validate_cords(input) 
    end 

    def get_lon_input
        puts "Longitude please: ex. 105.2519" 
        input = gets.chomp
        input.to_f if validate_cords(input) 
    end 

    def list_trails
        @trails = Trail.all
        @trails.each.with_index(1) do |trail, i|
            puts "#{i}. #{trail.name} - #{trail.location}"
        end
    end


    # input_limit = Trail.all.length
    #validate
    # puts "Enter the trail number you would like to know more about,
    # if input.to_i.between?(1, input_limit)
    #     #list available trail info
    #     display_trail_info(input)

    # def select_trail(input)
    #     puts "Enter the trail number you would like to know more about."
    #     if input.to_i.between?(1, input_limit)
    #         #list available trail info
    #         display_trail_info(input)

    #         # unless valid_selection(trail_input)
    #         #     puts "Invalid input. Let's try again."
    #         #     select_trail
    #         #   end
          
    #         #   if input == "search"
    #         #     get_search
    #         #     make_new_trails_list
    #         #     select_trail
    #         #   elsif trail_input == "new"
    #         #     make_new_trails_list
    #         #     select_trail
    #         #   else 
    #         #     get_trail(trail_input)
    #         #   end 
    #     end
    # end

    def get_trail(input)
        index = input.to_i - 1
        trail_selection = Trail.all[index]
        display_trail_info(trail_selection)
    end 

    def display_trail_info(input)
        if Trail.all.empty?
            Puts "Sorry, no trail information found, please try another location."
        else
            trail_index = @trails[input.to_i-1]
            puts "Trail: #{trail_index.name} - City: #{trail_index.location} - Dificulty: #{trail_index.difficulty}"
            puts "Length: #{trail_index.length} mi - Ascent: #{trail_index.ascent} ft - Descent: #{trail_index.descent} ft"
            puts "\"#{trail_index.summary}\""
        end
    end

### SORTING BY PARAMS  ###


    def display_by_search(filter)
        Trail.all_by_filter
    end

    def search_by_difficulty
        puts "Which difficulty would you like to search for? (blue, blue/black, black)"
        difficulty = gets.strip
        success = API.fetch_trails(difficulty)
        if success
            puts "Here are all the trails with difficulty: #{difficulty}"
            list_by_difficulty(difficulty)
        else
            puts "Sorry! We don't have that difficulty in our system, try blue, blue/black, or black"
            search_by_difficulty
        end
    end

    def list_by_difficulty(difficulty)
        Drink.all_by_difficulty(difficulty).each.with_index(1) do |trail, i|
            puts "#{i}. #{trail.name}"
        end
    end


    def sort_by_param_and_name(sort)
        @trails = Trail.all
        #@trails.sort_by {|k,v| v[0]}
        items.sort_by { |i| [i[:length], i[:name]] }

        #Trail.all.sort{|a,b| a.name <=> b.name}
    end



    # def loop_menu
    #     loop do
    #         puts ...
    #         input =
    #     gets.strip.chomp.downcase
    #         case input
    #         .
    #         .
    #         .
    #         when  "exit"
    #             break
    #         else
    #             .
    #             .
    #         end
    #     end
    # end

    def goodbye
        puts "Come back for more trail info!"
    end
   
end