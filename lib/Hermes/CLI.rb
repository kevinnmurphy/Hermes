
class CLI


    def run
        greeting        
        get_location
        menu
    end

    def greeting
        puts "\nWelcome to the Trail Runner App!"
    end

    def goodbye
        puts "Come back for more trail info!"
    end

    def menu
            #get input
            input = nil

            list_trails
        while input != "exit"

            puts "\nEnter \'list\' to view nearby trails, or type \'exit\' to leave at any time."
            puts "Or enter the trail number you would like to know more about."
            puts "Or type \'refine\' to search trails with filters."
            input = nil
            input = gets.strip.downcase
            input_limit = Trail.sorted.length
            #validate

            if input.to_i.between?(1, input_limit)
                display_trail_info(input)
            elsif input == "list"
                list_trails 
            elsif input == "refine"
                #sort trails by verious attributes
                puts "Type to sort by: Name, Difficulty, Popular, Length, or Ascent."
                input = gets.strip.downcase
                if input == "popular"
                    sort_by_popular
                elsif input == "name" || input == "length" || input == "ascent"
                    sort_by_param(input)
                elsif input == "difficulty"
                    search_by_difficulty
                else
                    puts "Please try another input command."
                end
            elsif input == "exit"
                goodbye
            else
                puts "\nNot sure what you want, type list or exit."
            end
        end
    end

######## LOCATION ########

    def get_location
        puts "\nTo manually put in your location type \'manual\', or type \'auto\' for auto-magic" 
        input = gets.strip.chomp
        if input == "manual"
            lat = get_lat_input
            lon = get_lon_input
            API.fetch_trails(lat, lon)
            check_data
        elsif input == "exit"
            exit
        elsif input == "auto"
            auto_location
        else
            puts "\nPlease try again."
            get_location
        end
    end

    def auto_location
        ip = API.fetch_location
        auto_lat = ip.auto_latitude.truncate(4)
        auto_lon = ip.auto_longitude.truncate(4)
        API.fetch_trails(auto_lat, auto_lon)
        check_data
    end

    def check_data
        if Trail.all.empty?
            puts "\nSorry no trail data found in selected area, please try another location."
            get_location
        end
    end

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
        puts "Longitude please: ex. -105.2519 Lon is negative in the US" 
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
        puts "\nPopular trails nearby:"
        trails = Trail.sorted[0..9]
        trails.each.with_index(1) do |trail, i|
        puts "#{i}. #{trail.name} - #{trail.location}"
        end
    end

    def display_trail_info(input)
        if Trail.all.empty?
            Puts "\nSorry, no trail information found, please try another location."
        else
            trail_index = Trail.sorted[input.to_i-1]
            puts "\nTrail: #{trail_index.name} - City: #{trail_index.location} - Dificulty: #{trail_index.difficulty}"
            puts "Length: #{trail_index.length} mi - Ascent: #{trail_index.ascent} ft - Descent: #{trail_index.descent} ft"
            puts "\"#{trail_index.summary}\""
        end
    end

######## SORTING  ########

    def search_by_difficulty
        puts "Which difficulty would you like to search for? (green, blue, black)"
        difficulty = gets.strip.downcase
        success = Trail.all_by_difficulty(difficulty).length > 0
        if success
            puts "Here are all the trails with difficulty: #{difficulty}"
            list_by_difficulty(difficulty)
        elsif input == "exit"
            exit
        else
            puts "Sorry! We don't have that difficulty in our system, try green, blue, or black"
            search_by_difficulty
        end
    end

    def list_by_difficulty(dif)
        Trail.sorted_clear
        sorted = Trail.all_by_difficulty(dif)

        sorted[0..9].each.with_index(1) do |trail, i|
            puts "#{i}. #{trail.name} - #{trail.location}"
        end
        sorted[0..9].each do |trail| Trail.sorted << trail
        end
    end

    def sort_by_param(property)
        Trail.sorted_clear

        sorted = Trail.all.sort_by {|k| k.send(property)}
        sorted[0..9].each.with_index(1) do |trail, i|
        puts "#{i}. #{trail.name} - #{trail.location}"
        end

        sorted[0..9].each do |trail| Trail.sorted << trail
        end
    end

    def sort_by_popular
        puts "\nPopular trails nearby:"
        Trail.sorted_clear
        sorted = Trail.all[0..9]     
        sorted[0..9].each.with_index(1) do |trail, i|
        puts "#{i}. #{trail.name} - #{trail.location}"
        end
        sorted[0..9].each do |trail| Trail.sorted << trail
        end
    end

end