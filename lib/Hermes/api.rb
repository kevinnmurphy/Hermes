class API
    extend Memorable::ClassMethods
    include Memorable::InstanceMethods

    #ENV[TRAILS_API_KEY]

    def initialize(attributes)
        attributes.each {|key, value| self.send(("#{key}="), value)}
    end

    def self.get_JSON_from_url(url)
        uri = URI.parse(url)
        response = Net::HTTP.get_response(uri)
        JSON.parse(response.body)
    end

    def self.fetch_location
        ip_api_key = "026d64c0e7e0120c12297098ce83f4ef"

        url =  "http://api.ipstack.com/check?access_key=#{ip_api_key}"
        ip_hash = get_JSON_from_url(url)
        

        location_instance = Location.new(ip: ip_hash["ip"], auto_latitude: ip_hash["latitude"], auto_longitude: ip_hash["longitude"])
    end

    def self.fetch_trails(lat, lon)
            # API args
            # maxDistance - Max distance, in miles, from lat, lon. Default: 30. Max: 200.
            # maxResults - Max number of trails to return. Default: 10. Max: 500.
            # sort - Values can be 'quality', 'distance'. Default: quality.
            # minLength - Min trail length, in miles. Default: 0 (no minimum).
            # minStars - Min star rating, 0-4. Default: 0.

        trails_api_key = "200766598-390ae1fea2810ed4dd1e179f968e4914"
        max_results = "30"
        max_distance = "15"
        url = "https://www.trailrunproject.com/data/get-trails?lat=#{lat}&lon=#{lon}&maxDistance=#{max_distance}&maxResults=#{max_results}&key=#{trails_api_key}"
        hash = get_JSON_from_url(url)
        #binding.pry
        array_of_trails = hash["trails"]

        array_of_trails.each do |trail_hash| 
            trail_instance = Trail.find_or_create_by_id({id: trail_hash["id"], name: trail_hash["name"], location: trail_hash["location"], length: trail_hash["length"], difficulty: trail_hash["difficulty"], ascent: trail_hash["ascent"], descent: trail_hash["descent"], summary: trail_hash["summary"], url: trail_hash["url"]})
        end
    end

end

######## TEST INFO ########

#trails = API.new.fetch_trails
#puts trails