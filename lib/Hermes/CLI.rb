
class CLI

    @@list_count = 10

    def run
        greeting        
        get_location
        get_list_count
        menu
    end

    def greeting
        puts "\nWelcome to the Trail Runner App!"
    end

    def goodbye
        puts "Come back for more trail info!"
    end

    def get_list_count
        puts "How many trail results would you like to see?"
        input = nil
        input = gets.strip.downcase
        input_limit = Trail.sorted.length
        if input.to_i.between?(1, input_limit)
            @@list_count = input.to_i
        else
            puts "Please try again." 
            get_list_count
        end
    end

    def menu
            #get input
            input = nil

            list_trails
        while input != "exit"

            puts "\nEnter \'list\' to view nearby trails, or type \'exit\' to leave at any time."
            puts "Enter \'new\' to start a new search."
            puts "Or enter the trail number you would like to know more about."
            puts "Or type \'refine\' to search trails with filters."
            input = nil
            input = gets.strip.downcase
            input_limit = Trail.sorted.length
            #validate
            if input.to_i.between?(1, @@list_count)
                display_trail_info(input)
            elsif input == "list"
                list_trails 
            elsif input == "refine"
                #sort trails by verious attributes
                puts "\nType to sort by: Name, Difficulty, Popular, Length, or Ascent."
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
            elsif input == "new"
                reset_all
                get_location
                get_list_count
                list_trails
            else
                puts "\nNot sure what you want, type list or exit."
            end
        end
    end

######## RESET ########

def reset_all
    Location.reset
    Trail.reset
    Trail.sorted_clear
end

######## LOCATION ########

    def get_location
        puts "\nTo manually put in your location type \'manual\', or type \'auto\' for auto-magic" 
        input = gets.strip.chomp
        if input == "manual"
            get_manual_input
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

    def get_manual_input
        puts "\nChoose between \'zipcode\' input or \'coordinate\' input: latitude and longitude."
        input = gets.strip.chomp
        if input == "zipcode"
            get_coord_from_zip
            check_data
        elsif input == "coordinate"
            lat = get_lat_input
            lon = get_lon_input
            API.fetch_trails(lat, lon)
            check_data
        elsif input == "exit"
            exit
        else
            puts "\nPlease try again."
            get_manual_input
        end
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

    def validate_zipcode(zip)
        zip if zip.to_i.to_s.length == 5
    end

    def get_coord_from_zip
        input = get_zip_input
        zip = API.fetch_zip(input)
        lat = zip.zip_lat
        lon = zip.zip_lon
        API.fetch_trails(lat, lon)
    end

    def get_zip_input
        puts "Zipcode please: ex. 12345" 
        input = gets.chomp
        if validate_zipcode(input)
            return input.to_i
        elsif input == "exit"
            exit
        else
            puts "Invalid entry, please use this format \'12345\'."
            #recursion
            get_zip_input
        end
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

    def list_trails(trails = Trail.sorted[0..@@list_count-1])
        puts "\nTrails:"
        trails.each.with_index(1) {|trail, i| puts "#{i}. #{trail.name} - #{trail.location}"}
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
        puts "\nWhich difficulty would you like to search for? (green, blue, black)"
        difficulty = gets.strip.downcase
        success = Trail.all_by_difficulty(difficulty).length > 0
        if success
            puts "\nHere are all the trails with difficulty: #{difficulty}"
            list_by_difficulty(difficulty)
        elsif input == "exit"
            exit
        else
            puts "Sorry! We don't have that difficulty in our system, try green, blue, or black"
            search_by_difficulty
        end
    end

    def list_by_difficulty(dif)
        puts "Trails by Difficulty:"
        Trail.sorted_clear
        sorted = Trail.all_by_difficulty(dif)
        sorted[0..@@list_count-1].each.with_index(1) do |trail, i|
            puts "#{i}. #{trail.name} - #{trail.location}"
        end
        sorted[0..@@list_count-1].each {|trail| Trail.sorted << trail}
    end

    def sort_by_param(property)
        puts "Trails by #{property.capitalize}:"
        Trail.sorted_clear
        sorted = Trail.all.sort_by {|k| k.send(property)}
        list_trails(sorted[0..@@list_count-1])
        sorted[0..9].each {|trail| Trail.sorted << trail}
    end

    def sort_by_popular
        puts "\nTrails by Popularity:"
        Trail.sorted_clear
        sorted = Trail.all     
        list_trails(sorted[0..@@list_count-1])
        sorted[0..@@list_count-1].each {|trail| Trail.sorted << trail}
    end

end