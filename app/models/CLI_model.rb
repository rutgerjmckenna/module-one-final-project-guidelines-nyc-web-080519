require 'rest-client'
require 'json'
require 'pry' 
require 'dotenv'

@@new_user

def greeting
    puts "Welecome to Showffeur! Making your live music organized"
    sleep 1
    login
    sleep 1
    puts "Welcome #{@@new_user.first_name}!"
    sleep 1
    puts "Would you like to..."
    sleep 1
    puts "1) See your current list of shows?"
    sleep 0.5
    puts "OR"
    sleep 1
    puts "2) Add a new show?"
    input = STDIN.gets.chomp
    if input == "1" && Event.all !=nil
        list_of_events
    elsif input == "1" && Event.all = nil 
    elsif input == "2"
        find_show
    else
        puts "Wanna try that again?"
        greeting
    end
end
#immeditately asks for name and returns your events tied to that name
    #would you like to add events to your schedule?


    #FIND SHOW requirements: city, state, time period (given ranges or day, weekend, or month), time-later-than
#-----------------------------------------------------------------------------------------------------------------------
# Login 

def login 
    puts "What is your first name?"
    f_name = STDIN.gets.chomp
    puts "What is your last name?"
    l_name = STDIN.gets.chomp
    puts "How old are you?"
    years_since_birth = STDIN.gets.chomp
    @@new_user = User.find_or_create_by({first_name: f_name, last_name: l_name, age: years_since_birth})
end 


#-----------------------------------------------------------------------------------------------------------------------
# READING MY EVENTS



def find_event
    puts "Which event are you looking for?"
    input = STDIN.gets.chomp
    event = Event.find_by(name: input)
        if event
            event
        else
            puts "Try a different event"
            find_event
        end
end

#-----------------------------------------------------------------------------------------------------------------------
# READING MY EVENTS

def list_of_events
    puts tp @@new_user.my_shows
    puts "What would you like to do next?"
    sleep 1
    puts "1) Return to main menu"
    sleep 1
    puts "2) Delete event"
    sleep 1
    puts "3) Look at local shows to add a new event"
    input = STDIN.gets.chomp
    if input == "1"
        greeting
    elsif input == "2"
        delete_event
    elsif input == "3"
        find_show
    end
end

#-----------------------------------------------------------------------------------------------------------------------
#DELETE EVENT



#-----------------------------------------------------------------------------------------------------------------------
#FINDING A SHOW

# def get_all_our_shows_from_api
#     all_shows = RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?classificationName=music&dmaId=296&apikey=#{ENV['API_KEY']}")
#     show_hash = JSON.parse(all_shows)
#         i = 0 
#         while i <= 19
#         name = show_hash["_embedded"]["events"][i]["name"]
#         city_name = show_hash["_embedded"]["events"][i]["_embedded"]["venues"][0]["city"]["name"]
#         state_name = show_hash["_embedded"]["events"][i]["_embedded"]["venues"][0]["state"]["stateCode"]
#         venue_name = show_hash["_embedded"]["events"][i]["_embedded"]["venues"][0]["name"]
#         date = show_hash["_embedded"]["events"][i]["dates"]["start"]["localDate"]
#         time = show_hash["_embedded"]["events"][i]["dates"]["start"]["localTime"]
#         genre = show_hash["_embedded"]["events"][i]["classifications"][0]["genre"]["name"]
#         Show.create({name: name, city: city_name, state: state_name, venue: venue_name, local_date: date, local_time: time, genre: genre})
#         i += 1
#     end 
# end 

# get_all_our_shows_from_api



def find_show
    puts "Here are the shows currently avaliable in your area:"
    sleep 1
    puts tp Show.all
    sleep 2
    could_create_event
end

#-----------------------------------------------------------------------------------------------------------------------
#WOULD YOU LIKKE TO CREATE EVENT

def could_create_event
    puts "Would you like to add one of these to your events?"
    sleep 1
    puts "1) Yes please!"
    sleep 1
    puts "2) No thank you, I'll return to the main menu."
    input = STDIN.gets.chomp
    if input == "1"
        create_event
    elsif input == "2"
        greeting
    else
        "Please choose 1 or 2"
        could_create_event
    end
end

#-----------------------------------------------------------------------------------------------------------------------
#CREATE EVENT

def create_event
    puts "Which show would you like to add to your list of events?"
    input = STDIN.gets.chomp.to_i
    if input.between?(0,21)
        Event.create({user_id: @@new_user.id, show_id: input, name: "Event"})
        puts "The show has been added to your events list."
        greeting
    elsif puts "Please enter a number between 1 and 20"
        create_event
    end 
    #exit method
    #main menu
end