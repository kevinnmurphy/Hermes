#interacts with user
#puts and gets statements go here
#controls flow
class Hermes::CLI

    @@Base_url = ""

    def run
        puts "Welcome to the Trail Runner App!"
        #make_trails
        #add_attributes_to_trails
        #display_trails
    end

    def make_trails
        trails_array = Scraper.scrape_index_page(@@Base_url + "")
        Trail.create_from_collection(trails_array)
    end

    def add_attributes_to_trails
        Trail.all.each do |trail|
            attributes = Scraper.scrape_data_page(@@Base_url + "")
            trail.add_trail_attributes(attributes)
        end
    end

    def display_trails
        Trails.all.each do |trail|
            puts "#{trail.name}"
            puts "#{trail.location}"
            puts "#{trail.length} mi"
            puts "#{trail.difficulty}"
            puts "#{trail.ascent} ft"
        end
    end

end