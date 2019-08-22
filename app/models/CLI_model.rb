require 'rest-client'
require 'json'
require 'pry' 
require 'dotenv'
require 'colorize'

$new_user = User.new

def greeting
    puts logo.to_s.colorize(:blue)
    puts "Welecome to Showffeur! Making your live music organized."
    puts ""
    sleep 1
    login
    sleep 1
    puts "Welcome #{$new_user.first_name}!"
    welcome_back
end

def logo 
    <<-STRING
    ,gg,                                                                                            
    i8""8i   ,dPYb,                                   ,dPYb,  ,dPYb,                                 
    `8,,8'   IP'`Yb                                   IP'`Yb  IP'`Yb                                 
     `88'    I8  8I                                   I8  8I  I8  8I                                 
     dP"8,   I8  8'                                   I8  8'  I8  8'                                 
    dP' `8a  I8 dPgg,     ,ggggg,    gg    gg    gg   I8 dP   I8 dP    ,ggg,   gg      gg   ,gggggg, 
   dP'   `Yb I8dP" "8I   dP"  "Y8ggg I8    I8    88bg I8dP    I8dP    i8" "8i  I8      8I   dP""""8I 
_ ,dP'     I8 I8P    I8  i8'    ,8I   I8    I8    8I   I8P     I8P     I8, ,8I  I8,    ,8I  ,8'    8I 
"888,,____,dP,d8     I8,,d8,   ,d8'  ,d8,  ,d8,  ,8I  ,d8b,_  ,d8b,_   `YbadP' ,d8b,  ,d8b,,dP     Y8,
a8P"Y88888P" 88P     `Y8P"Y8888P"    P""Y88P""Y88P"   PI8"8888PI8"8888888P"Y8888P'"Y88P"`Y88P      `Y8
                                                      I8 `8,  I8 `8,                                 
                                                      I8  `8, I8  `8,                                
                                                      I8   8I I8   8I                                
                                                      I8   8I I8   8I                                
                                                      I8, ,8' I8, ,8'                                
                                                       "Y8P'   "Y8P'                                 
    
    STRING
end

def welcome_back
    puts ""
    puts "Please select an option from our main menu."
    puts ""
    puts "*** MAIN MENU ***"
    puts "1. See your current list of shows?"
    puts "2. Add a new show?"
    input = STDIN.gets.chomp
    puts ""
    if input == "1" && Event.all != []
        list_of_events
    elsif input == "1" && Event.all == []
        puts "You have no shows."
        welcome_back
    elsif input == "2"
        find_show
    elsif input == "exit"
        welcome_back
    else
        puts "Wanna try that again?"
        welcome_back
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
    puts ""
    puts "What is your last name?"
    l_name = STDIN.gets.chomp
    $new_user = User.find_or_create_by({first_name: f_name, last_name: l_name})
    puts ""
end 


#-----------------------------------------------------------------------------------------------------------------------
# READING MY EVENTS



def find_event
    puts "Which event are you looking for?"
    input = STDIN.gets.chomp
    event = Event.find_by(name: input)
        if event
            event
        elsif input == "exit"
            welcome_back
        else
            puts "Try a different event"
            find_event
        end
end

#-----------------------------------------------------------------------------------------------------------------------
# READING MY EVENTS

def list_of_events
    puts $new_user.my_shows
    puts "What would you like to do next?"
    sleep 1
    puts "1) Return to main menu"
    puts "2) Delete event"
    puts "3) Look at local shows to add a new event"
    input = STDIN.gets.chomp
    puts ""
    if input == "1"
        welcome_back
    elsif input == "2"
        delete_event
    elsif input == "3"
        find_show
    elsif input == "exit"
        welcome_back
    end
end

#-----------------------------------------------------------------------------------------------------------------------
#DELETE EVENT

# def delete_event
#     puts "Which event would you like to delete?"
#     input = STDIN.gets.chomp.to_i
    
#     Event.all.each do |event|
#         i = 0
#         if i < Event.all.count
#             event.show_id == input && event.user_id == $new_user.id 
#             event.delete(input)
#             puts "That show is now off your list."
#         elsif
#             i += 1
#         else puts "That is not a show in your list"
#             delete_event
#         end 
#     end 
# end 

def delete_event
    puts "Which event would you like to delete?"
    input = STDIN.gets.chomp.to_i
    if 
    show = Show.find(input)
    user = User.find($new_user.id)
    Event.where(show_id: show.id, user_id: user.id).destroy_all
    puts ""
    puts "Your show has been deleted."
    welcome_back
    else 
    "This show doesn't exist, dum dum!"
    welcome_back
    end 
end 


#-----------------------------------------------------------------------------------------------------------------------
# FINDING A SHOW

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
    puts ""
    puts "Would you like to add one of these to your events?"
    sleep 1
    puts "1) Yes please!"
    puts "2) No thank you, I'll return to the main menu."
    input = STDIN.gets.chomp
    if input == "1"
        create_event
    elsif input == "2"
        welcome_back
    elsif input == "exit"
        welcome_back
    else
        "Please choose 1 or 2"
        could_create_event
    end
end

#-----------------------------------------------------------------------------------------------------------------------
#CREATE EVENT

def create_event
    puts ""
    puts "Which show would you like to add to your list of events?"
    input = STDIN.gets.chomp.to_i
    if input.between?(0,21)
        Event.create({user_id: $new_user.id, show_id: input, name: "Event"})
        puts ""
        puts ".".colorize(:red)
        sleep 0.5
        puts "..".colorize(:yellow)
        sleep 0.5
        puts "...".colorize(:green)
        sleep 0.5
        puts ""
        puts "The show has been added to your events list."
        sleep 1
        puts "Sending you back to the main menu."
        sleep 1.5
        welcome_back
    elsif puts "Please enter a number between 1 and 20"
        create_event
    elsif input == "exit"
        welcome_back
    end 
    #exit method
    #main menu
end