class API
    attr_accessor :lat, :lon

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
        #ip api
        ip_api_key = "026d64c0e7e0120c12297098ce83f4ef"

        ############################### >>

        # url =  "http://api.ipstack.com/check?access_key=#{ip_api_key}"
        # ip_hash = get_JSON_from_url(url)
        
        ######  TEST DATA TOGGLE ######

        url = "https://www.google.com/"
        ip_hash = @@ip_hash_info

        ############################### <<

        location_instance = Location.new(ip: ip_hash["ip"], auto_latitude: ip_hash["latitude"], auto_longitude: ip_hash["longitude"])
    end

    #def self.fetch_trails(lat:, lon:)
    def self.fetch_trails(lat = "40.0274", lon = "-105.2519")
        ########################################################################################## >>

        # trails_api_key = "200766598-390ae1fea2810ed4dd1e179f968e4914"
        # max_distance = "15"
        # url = "https://www.trailrunproject.com/data/get-trails?lat=#{lat}&lon=#{lon}&maxDistance=#{max_distance}&key=#{trails_api_key}"
        # hash = get_JSON_from_url(url)
        # #binding.pry
        # array_of_trails = hash["trails"]

        ##########################################################################################
        ## -- SWITCH COMMENT TO TOGGLE BETWEEN API AND HARDCODE PULL -- ##
        ##########################################################################################

        url = "https://www.google.com/"
        array_of_trails = @@trail_hash_info["trails"]

        ########################################################################################## <<

        array_of_trails.each do |trail_hash| 
            trail_instance = Trail.new({id: trail_hash["id"], name: trail_hash["name"], location: trail_hash["location"], length: trail_hash["length"], difficulty: trail_hash["difficulty"], ascent: trail_hash["ascent"], descent: trail_hash["descent"], summary: trail_hash["summary"], url: trail_hash["url"]}) 

        end
        #binding.pry
    end


    def saved_trails

    end

    def self.scrape_trails

    end


#trails = API.new.fetch_trails
#puts trails
@@ip_hash_info = {"ip"=>"76.204.101.10",
    "type"=>"ipv4",
    "continent_code"=>"NA",
    "continent_name"=>"North America",
    "country_code"=>"US",
    "country_name"=>"United States",
    "region_code"=>"GA",
    "region_name"=>"Georgia",
    "city"=>"Sugar Hill",
    "zip"=>"30519",
    "latitude"=>34.09321975708008,
    "longitude"=>-83.93594360351562,
}

@@trail_hash_info = {"trails"=>
    [{"id"=>7003363,
      "name"=>"Indian Seats Loop",
      "type"=>"Run",
      "summary"=>"A moderate trail with plenty of amazing views to reward you for your effort! It is especially stunning in the fall.",
      "difficulty"=>"blue",
      "stars"=>4.1,
      "starVotes"=>22,
      "location"=>"Cumming, Georgia",
      "url"=>"https://www.trailrunproject.com/trail/7003363/indian-seats-loop",
      "imgSqSmall"=>"https://cdn2.apstatic.com/photos/hike/7025187_sqsmall_1554911715.jpg",
      "imgSmall"=>"https://cdn2.apstatic.com/photos/hike/7025187_small_1554911715.jpg",
      "imgSmallMed"=>"https://cdn2.apstatic.com/photos/hike/7025187_smallMed_1554911715.jpg",
      "imgMedium"=>"https://cdn2.apstatic.com/photos/hike/7025187_medium_1554911715.jpg",
      "length"=>3.9,
      "ascent"=>502,
      "descent"=>-502,
      "high"=>1660,
      "low"=>1212,
  
  
  
      "longitude"=>-84.1389,
      "latitude"=>34.2548,
      "conditionStatus"=>"All Clear",
      "conditionDetails"=>"Some Mud",
      "conditionDate"=>"2020-05-03 12:44:14"},
     {"id"=>7036417,
      "name"=>"Miller Trail Waterfall Loop",
      "type"=>"Run",
      "summary"=>"This is a 3.4 mile run on a shaded path to the dam and back. A scenic waterfall flows here in the wet season.",
      "difficulty"=>"green",
      "stars"=>4.5,
      "starVotes"=>2,
      "location"=>"Dacula, Georgia",
      "url"=>"https://www.trailrunproject.com/trail/7036417/miller-trail-waterfall-loop",
      "imgSqSmall"=>"https://cdn2.apstatic.com/photos/hike/7057491_sqsmall_1555947190.jpg",
      "imgSmall"=>"https://cdn2.apstatic.com/photos/hike/7057491_small_1555947190.jpg",
      "imgSmallMed"=>"https://cdn2.apstatic.com/photos/hike/7057491_smallMed_1555947190.jpg",
      "imgMedium"=>"https://cdn2.apstatic.com/photos/hike/7057491_medium_1555947190.jpg",
      "length"=>2.7,
  
 
  
      "ascent"=>316,
      "descent"=>-320,
      "high"=>1026,
      "low"=>889,
      "longitude"=>-83.8853,
      "latitude"=>34.054,
      "conditionStatus"=>"Unknown",
      "conditionDetails"=>nil,
      "conditionDate"=>"1970-01-01 00:00:00"},
     {"id"=>7087984,
      "name"=>"Suwanee Creek to Berry Lake Loop",
      "type"=>"Run",
      "summary"=>"A peaceful run starting at Suwanee Creek Park and making a loop of Berry Lake.",
      "difficulty"=>"green",
      "stars"=>4,
      "starVotes"=>1,
      "location"=>"Suwanee, Georgia",
      "url"=>"https://www.trailrunproject.com/trail/7087984/suwanee-creek-to-berry-lake-loop",
      "imgSqSmall"=>"https://cdn2.apstatic.com/photos/hike/7064432_sqsmall_1573249629.jpg",
  
  
  
      "imgSmall"=>"https://cdn2.apstatic.com/photos/hike/7064432_small_1573249629.jpg",
      "imgSmallMed"=>"https://cdn2.apstatic.com/photos/hike/7064432_smallMed_1573249629.jpg",
      "imgMedium"=>"https://cdn2.apstatic.com/photos/hike/7064432_medium_1573249629.jpg",
      "length"=>4.3,
      "ascent"=>222,
      "descent"=>-222,
      "high"=>998,
      "low"=>941,
      "longitude"=>-84.0874,
      "latitude"=>34.0344,
      "conditionStatus"=>"Unknown",
      "conditionDetails"=>nil,
      "conditionDate"=>"1970-01-01 00:00:00"},
     {"id"=>7087592,
      "name"=>"Tribble Mill Multi-Use Path",
      "type"=>"Run",
      "summary"=>"A paved loop that circles Ozora Lake.",
      "difficulty"=>"blue",
      "stars"=>4,
  

  
      "starVotes"=>1,
      "location"=>"Grayson, Georgia",
      "url"=>"https://www.trailrunproject.com/trail/7087592/tribble-mill-multi-use-path",
      "imgSqSmall"=>"https://cdn2.apstatic.com/photos/hike/7064427_sqsmall_1573241298.jpg",
      "imgSmall"=>"https://cdn2.apstatic.com/photos/hike/7064427_small_1573241298.jpg",
      "imgSmallMed"=>"https://cdn2.apstatic.com/photos/hike/7064427_smallMed_1573241298.jpg",
      "imgMedium"=>"https://cdn2.apstatic.com/photos/hike/7064427_medium_1573241298.jpg",
      "length"=>2.9,
      "ascent"=>453,
      "descent"=>-467,
      "high"=>1009,
      "low"=>888,
      "longitude"=>-83.9029,
      "latitude"=>33.9081,
      "conditionStatus"=>"Unknown",
      "conditionDetails"=>nil,
      "conditionDate"=>"1970-01-01 00:00:00"},
     {"id"=>7020182,
      "name"=>"Bowman's Island Loop",
  

  
      "type"=>"Run",
      "summary"=>"Views of the Chattahoochee right after it emerges form the Buford Dam and is still blue/green!",
      "difficulty"=>"blue",
      "stars"=>3.7,
      "starVotes"=>6,
      "location"=>"Sugar Hill, Georgia",
      "url"=>"https://www.trailrunproject.com/trail/7020182/bowmans-island-loop",
      "imgSqSmall"=>"https://cdn2.apstatic.com/photos/hike/7022713_sqsmall_1554843947.jpg",
      "imgSmall"=>"https://cdn2.apstatic.com/photos/hike/7022713_small_1554843947.jpg",
      "imgSmallMed"=>"https://cdn2.apstatic.com/photos/hike/7022713_smallMed_1554843947.jpg",
      "imgMedium"=>"https://cdn2.apstatic.com/photos/hike/7022713_medium_1554843947.jpg",
      "length"=>6.2,
      "ascent"=>378,
      "descent"=>-377,
      "high"=>1042,
      "low"=>920,
      "longitude"=>-84.08,
      "latitude"=>34.1567,
      "conditionStatus"=>"Unknown",
  

  
      "conditionDetails"=>nil,
      "conditionDate"=>"1970-01-01 00:00:00"},
     {"id"=>7017566,
      "name"=>"Medlock Loop",
      "type"=>"Run",
      "summary"=>"A nice little romp along the Chattahoochee through young, ferny forest.",
      "difficulty"=>"greenBlue",
      "stars"=>3,
      "starVotes"=>4,
      "location"=>"Berkeley Lake, Georgia",
      "url"=>"https://www.trailrunproject.com/trail/7017566/medlock-loop",
      "imgSqSmall"=>"https://cdn2.apstatic.com/photos/hike/7017004_sqsmall_1554828630.jpg",
      "imgSmall"=>"https://cdn2.apstatic.com/photos/hike/7017004_small_1554828630.jpg",
      "imgSmallMed"=>"https://cdn2.apstatic.com/photos/hike/7017004_smallMed_1554828630.jpg",
      "imgMedium"=>"https://cdn2.apstatic.com/photos/hike/7017004_medium_1554828630.jpg",
      "length"=>1.6,
      "ascent"=>171,
      "descent"=>-171,
      "high"=>962,

  
      "low"=>890,
      "longitude"=>-84.2021,
      "latitude"=>33.9959,
      "conditionStatus"=>"Unknown",
      "conditionDetails"=>nil,
      "conditionDate"=>"1970-01-01 00:00:00"},
     {"id"=>7017032,
      "name"=>"Abbots Bridge Trail",
      "type"=>"Run",
      "summary"=>"A quick little jaunt through shady woods next to a gently flowing river.",
      "difficulty"=>"green",
      "stars"=>2,
      "starVotes"=>1,
      "location"=>"Johns Creek, Georgia",
      "url"=>"https://www.trailrunproject.com/trail/7017032/abbots-bridge-trail",
      "imgSqSmall"=>"https://cdn2.apstatic.com/photos/hike/7020033_sqsmall_1554837598.jpg",
      "imgSmall"=>"https://cdn2.apstatic.com/photos/hike/7020033_small_1554837598.jpg",
      "imgSmallMed"=>"https://cdn2.apstatic.com/photos/hike/7020033_smallMed_1554837598.jpg",
      "imgMedium"=>"https://cdn2.apstatic.com/photos/hike/7020033_medium_1554837598.jpg",
  

  
      "length"=>0.6,
      "ascent"=>5,
      "descent"=>-5,
      "high"=>900,
      "low"=>895,
      "longitude"=>-84.1721,
      "latitude"=>34.0245,
      "conditionStatus"=>"Unknown",
      "conditionDetails"=>nil,
      "conditionDate"=>"1970-01-01 00:00:00"},
     {"id"=>7036452,
      "name"=>"Miller Trail Loop",
      "type"=>"Trail",
      "summary"=>"This is a nice easy 2.4 mile paved trail looping around beautiful Miller Lake. Bring the whole family!",
      "difficulty"=>"greenBlue",
      "stars"=>5,
      "starVotes"=>2,
      "location"=>"Dacula, Georgia",
      "url"=>"https://www.trailrunproject.com/trail/7036452/miller-trail-loop",
  

  
      "imgSqSmall"=>"https://cdn2.apstatic.com/photos/hike/7057491_sqsmall_1555947190.jpg",
      "imgSmall"=>"https://cdn2.apstatic.com/photos/hike/7057491_small_1555947190.jpg",
      "imgSmallMed"=>"https://cdn2.apstatic.com/photos/hike/7057491_smallMed_1555947190.jpg",
      "imgMedium"=>"https://cdn2.apstatic.com/photos/hike/7057491_medium_1555947190.jpg",
      "length"=>2.4,
      "ascent"=>234,
      "descent"=>-238,
      "high"=>994,
      "low"=>889,
      "longitude"=>-83.8853,
      "latitude"=>34.054,
      "conditionStatus"=>"All Clear",
      "conditionDetails"=>"Dry",
      "conditionDate"=>"2020-05-19 16:23:11"},
     {"id"=>7090498,
      "name"=>"Bridge Loop",
      "type"=>"Trail",
      "summary"=>"Great loop through the beautiful Chicopee Woods Nature Preserve, up and down hills with several stream crossings.",
      "difficulty"=>"blue",
  

  
      "stars"=>5,
      "starVotes"=>1,
      "location"=>"Oakwood, Georgia",
      "url"=>"https://www.trailrunproject.com/trail/7090498/bridge-loop",
      "imgSqSmall"=>"https://cdn2.apstatic.com/photos/hike/7028473_sqsmall_1554918618.jpg",
      "imgSmall"=>"https://cdn2.apstatic.com/photos/hike/7028473_small_1554918618.jpg",
      "imgSmallMed"=>"https://cdn2.apstatic.com/photos/hike/7028473_smallMed_1554918618.jpg",
      "imgMedium"=>"https://cdn2.apstatic.com/photos/hike/7028473_medium_1554918618.jpg",
      "length"=>2.8,
      "ascent"=>396,
      "descent"=>-405,
      "high"=>1181,
      "low"=>998,
      "longitude"=>-83.834,
      "latitude"=>34.2452,
      "conditionStatus"=>"All Clear",
      "conditionDetails"=>"Mostly Dry",
      "conditionDate"=>"2020-04-15 08:19:23"},
     {"id"=>7090502,
  

  
      "name"=>"Lake Loop",
      "type"=>"Trail",
      "summary"=>"Loop through the Chicopee Woods Nature Preserve on the Lake Loop B Bypass.",
      "difficulty"=>"blue",
      "stars"=>5,
      "starVotes"=>1,
      "location"=>"Oakwood, Georgia",
      "url"=>"https://www.trailrunproject.com/trail/7090502/lake-loop",
      "imgSqSmall"=>"https://cdn2.apstatic.com/photos/hike/7028473_sqsmall_1554918618.jpg",
      "imgSmall"=>"https://cdn2.apstatic.com/photos/hike/7028473_small_1554918618.jpg",
      "imgSmallMed"=>"https://cdn2.apstatic.com/photos/hike/7028473_smallMed_1554918618.jpg",
      "imgMedium"=>"https://cdn2.apstatic.com/photos/hike/7028473_medium_1554918618.jpg",
      "length"=>2.9,
      "ascent"=>336,
      "descent"=>-327,
      "high"=>1121,
      "low"=>985,
      "longitude"=>-83.8252,
      "latitude"=>34.2276,
  

  
      "conditionStatus"=>"All Clear",
      "conditionDetails"=>"Mostly Dry",
      "conditionDate"=>"2020-05-02 12:39:38"}],
   "success"=>1}
end