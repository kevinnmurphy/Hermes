
##TODO  
#call them when fetching
#grab 20 results, only show 10
#fix sorting
#clean up extra methods and make a video
#submit


class CLI


    def run
        greeting        
        #get_location
        get_location_test
        menu
    end

    def greeting
        puts "Welcome to the Trail Runner App!"
    end

    def goodbye
        puts "Come back for more trail info!"
    end

    def menu
            #get input
            input = nil

            list_trails
        while input != "exit"

            

            puts "Enter \'list\' to view nearby trails, or type \'exit\' to leave at any time."
            puts "Or enter the trail number you would like to know more about."
            puts "Or type \'refine\' to search trails by: nearest, difficulty, popularity, ascent, or length."
            input = nil
            input = gets.strip.downcase
            input_limit = Trail.all.length
            #validate

            if input.to_i.between?(1, input_limit)
                #list available trail info
                display_trail_info(input)
            elsif input == "list"
                puts "Nearby Trails:"
                list_trails 
            elsif input == "refine"
                #sort trails by verious attributes
                puts "Type to sort by: Popular, Nearest, Length, Ascent, or Difficulty."
                input = gets.strip.downcase
                if input == "popular"

                elsif input == "nearest"

                elsif input == "length"

                elsif input == "ascent"

                elsif input == "difficulty"
                  search_by_difficulty
                else
                    puts "Please try another input command."

            elsif input == "exit"
                goodbye
            else
                puts "Not sure what you want, type list or exit."
            end
        end
    end

    def get_location
        puts "To manually put in your location type \'manual\', or type \'auto\' for auto" 
        input = gets.strip.chomp
        if input == "manual"
            lat = get_lat_input
            lon = get_lon_input
            API.fetch_trails(lat, lon)
            if Trail.all.empty?
                puts "Sorry no trail data found in selected area, please try another location./n"
                get_location
            end
        elsif input == "exit"
            exit
        elsif input == "auto"
            auto_location
        else
            puts "Please try again."
            get_location
        end
    end

    def get_location_test
            #lat = get_lat_input
            #lon = get_lon_input
            ## lat = 40.0274 #boulder, co
            ## lon = 105.2519
            lat = 34.1065 #sugar hill, ga
            lon = 84.0335 #convert input to negative for US
            API.fetch_trails(lat, lon)
    end

    def auto_location
        ip = API.fetch_location
        auto_lat = ip.auto_latitude.truncate(4)
        auto_lon = ip.auto_longitude.truncate(4)
        API.fetch_trails(auto_lat, auto_lon)
        if Trail.all.empty?
            puts "Sorry no trail data found in your area, please try another location."
            get_location
        end
    end


        ##Should I truncate input instead of limiting ending count?
        #input.truncate(4)
        ##Is there a way to combine these?
    def validate_lat_cords(coord)
        make_four = "%.4f" % coord.to_f
        valid_beginning_count = coord.to_s.split(".")[0].to_s.length
        valid_limit = make_four.to_f.between?(-90, 90)
        valid_ending_count = make_four.to_s.split(".")[1].to_s.length
        coord if valid_beginning_count.between?(1, 3) && valid_limit  && valid_ending_count == 4    
    end
    def validate_lon_cords(coord)
        make_four = "%.4f" % coord.to_f
        valid_beginning_count = coord.to_s.split(".")[0].to_s.length
        valid_limit = make_four.to_f.between?(-180, 180)
        valid_ending_count = make_four.to_s.split(".")[1].to_s.length
        coord if valid_beginning_count.between?(1, 4) && valid_limit  && valid_ending_count == 4
    end

    def get_lat_input
        puts "Latitude please: ex. 40.0274" 
        input = gets.chomp
        if validate_lat_cords(input)
            input.to_f
            return input.to_f
        elsif input == "exit"
            exit
        else
            puts "Invalid entry, please use this format \'12.345\'."
            puts "Latitude must be between -90 and 90."
            #recursion
            get_lat_input
        end
    end 

    def get_lon_input
        puts "Longitude please: ex. -105.2519" 
        input = gets.chomp
        if validate_lon_cords(input) 
            return input.to_f
        elsif input == "exit"
            exit
        else
            puts "Invalid entry, please use this format \'12.3456\'."
            puts "Longitude must be between -180 and 180."
            #recursion
            get_lon_input
        end
    end 

    def list_trails
        @trails = Trail.all
        @trails.each.with_index(1) do |trail, i|
            puts "#{i}. #{trail.name} - #{trail.location}"
        end
    end

    def get_trail(input, limit)
        index = input.to_i - 1
        trail_selection = Trail.all[index]
        display_trail_info(trail_selection)
    end 

    def display_trail_info(input)
        if Trail.all.empty?
            Puts "Sorry, no trail information found, please try another location. /n"
            #get_location
        else
            trail_index = @trails[input.to_i-1]
            puts "Trail: #{trail_index.name} - City: #{trail_index.location} - Dificulty: #{trail_index.difficulty}"
            puts "Length: #{trail_index.length} mi - Ascent: #{trail_index.ascent} ft - Descent: #{trail_index.descent} ft"
            puts "\"#{trail_index.summary}\""
        end
    end

### SORTING BY PARAMS  ###

    #Trail.all.sort {|a,b| a.name <=> b.name}
    #Trail.all.sort_by {|trail| trail.name}

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
            puts "Sorry! We don't have that difficulty in our system, try green, blue, or black"
            search_by_difficulty
        end
    end

    def list_by_difficulty(difficulty)
        Trail.all_by_difficulty(difficulty).each.with_index(1) do |trail, i|
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
   
end