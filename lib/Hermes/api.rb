require 'open-uri'
require 'net/http'
require 'nokogiri'
require 'pry'
require 'json'

#make calls to api
class Hermes::API

    def fetch_trails
        trails_api_key = ENV[TRAILS_API_KEY]
        #trails_api_key = "200766598-390ae1fea2810ed4dd1e179f968e4914"
        lat = "40.0274"
        lon = "-105.2519"
        #max_distance = "10"
        #url = "https://www.trailrunproject.com/data/get-trails?lat=#{lat}&lon=#{lon}&maxDistance=10&key=#{trails_api_key}"
        url = "https://www.trailrunproject.com/data/get-trails?lat=40.0274&lon=-105.2519&maxDistance=10&key=200766598-390ae1fea2810ed4dd1e179f968e4914"
        uri = URI.parse(url)
        response = Net::HTTP.get(uri)
        hash = JSON.parse(response)
        hash2 = {
            "trails": [
                {
                    "id": 7011192,
                    "name": "Boulder Skyline Traverse",
                    "type": "Run",
                    "summary": "The classic long mountain route in Boulder.",
                    "difficulty": "black",
                    "stars": 4.7,
                    "starVotes": 78,
                    "location": "Superior, Colorado",
                    "url": "https:\/\/www.trailrunproject.com\/trail\/7011192\/boulder-skyline-traverse",
                    "imgSqSmall": "https:\/\/cdn2.apstatic.com\/photos\/hike\/7048859_sqsmall_1555540136.jpg",
                    "imgSmall": "https:\/\/cdn2.apstatic.com\/photos\/hike\/7048859_small_1555540136.jpg",
                    "imgSmallMed": "https:\/\/cdn2.apstatic.com\/photos\/hike\/7048859_smallMed_1555540136.jpg",
                    "imgMedium": "https:\/\/cdn2.apstatic.com\/photos\/hike\/7048859_medium_1555540136.jpg",
                    "length": 16.3,
                    "ascent": 5409,
                    "descent": -5492,
                    "high": 8492,
                    "low": 5417,
                    "longitude": -105.2582,
                    "latitude": 39.9388,
                    "conditionStatus": "All Clear",
                    "conditionDetails": "Dry",
                    "conditionDate": "2020-05-08 16:44:51"
                },
                {
                    "id": 7000130,
                    "name": "Bear Peak Out and Back",
                    "type": "Run",
                    "summary": "A must-do run for Boulder locals and visitors alike!",
                    "difficulty": "black",
                    "stars": 4.6,
                    "starVotes": 115,
                    "location": "Boulder, Colorado",
                    "url": "https:\/\/www.trailrunproject.com\/trail\/7000130\/bear-peak-out-and-back",
                    "imgSqSmall": "https:\/\/cdn2.apstatic.com\/photos\/hike\/7005382_sqsmall_1554312030.jpg",
                    "imgSmall": "https:\/\/cdn2.apstatic.com\/photos\/hike\/7005382_small_1554312030.jpg",
                    "imgSmallMed": "https:\/\/cdn2.apstatic.com\/photos\/hike\/7005382_smallMed_1554312030.jpg",
                    "imgMedium": "https:\/\/cdn2.apstatic.com\/photos\/hike\/7005382_medium_1554312030.jpg",
                    "length": 5.7,
                    "ascent": 2541,
                    "descent": -2540,
                    "high": 8342,
                    "low": 6103,
                    "longitude": -105.2755,
                    "latitude": 39.9787,
                    "conditionStatus": "All Clear",
                    "conditionDetails": "Dry",
                    "conditionDate": "2020-05-16 18:13:49"
                },
                {
                    "id": 7004226,
                    "name": "Sunshine Lion's Lair Loop",
                    "type": "Run",
                    "summary": "Great Mount Sanitas views are the reward for this gentler loop in Sunshine Canyon.",
                    "difficulty": "blueBlack",
                    "stars": 4.5,
                    "starVotes": 108,
                    "location": "Boulder, Colorado",
                    "url": "https:\/\/www.trailrunproject.com\/trail\/7004226\/sunshine-lions-lair-loop",
                    "imgSqSmall": "https:\/\/cdn2.apstatic.com\/photos\/hike\/7039883_sqsmall_1555092747.jpg",
                    "imgSmall": "https:\/\/cdn2.apstatic.com\/photos\/hike\/7039883_small_1555092747.jpg",
                    "imgSmallMed": "https:\/\/cdn2.apstatic.com\/photos\/hike\/7039883_smallMed_1555092747.jpg",
                    "imgMedium": "https:\/\/cdn2.apstatic.com\/photos\/hike\/7039883_medium_1555092747.jpg",
                    "length": 5.3,
                    "ascent": 1261,
                    "descent": -1282,
                    "high": 6800,
                    "low": 5530,
                    "longitude": -105.2979,
                    "latitude": 40.02,
                    "conditionStatus": "All Clear",
                    "conditionDetails": "Dry - Clear of ice and mud",
                    "conditionDate": "2020-05-08 14:06:04"
                }
            ],
            "success": 1
        }

        array_of_trails = hash2["name"] #=> blank?
binding.pry
        array_of_trails.each do |trail_hash| 
            trail_instance = Trail.new
            trail_instance.name = trail_hash["name"]  #"idTrail"
            trail_instance.location = trail_hash["location"] #"trailLocation"
            trail_instance.length = trail_hash["length"] 
            trail_instance.difficulty = trail_hash["difficulty"]
            trail_instance.ascent = trail_hash["ascent"]
            trail_instance.descent = trail_hash["descent"]
            trail_instance.summary = trail_hash["summary"]
            trail_instance.url = trail_hash["url"]

        end
    end

#trails = API.new.fetch_trails
#puts trails

end