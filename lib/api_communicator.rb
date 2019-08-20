require 'rest-client'
require 'json'
require 'pry'

def get_all_our_shows_from_api
    all_shows = RestClient.get('https://app.ticketmaster.com/discovery/v2/events.json?classificationName=music&dmaId=296&apikey=BSaMGswTIf5EufTzjcuVQb61T01ffvA9')
    show_hash = JSON.parse(all_shows)
    binding.pry
end

get_all_our_shows_from_api