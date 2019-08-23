require 'rest-client'
require 'json'
require 'pry' 
require 'dotenv'
require 'colorize'

$new_user = User.new

#-----------------------------------------------------------------------------------------------------------------------
# Welcome and Main Menu 

def greeting
    puts logo.to_s.colorize(:blue)
    puts "Welecome to Showffeur! Making your live music organized.".colorize(:blue)
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
    puts "*********** MAIN - MENU ***********".colorize(:green)
    sleep 0.5
    puts "1. See your current list of shows."
    sleep 0.5
    puts "-----------------------------------".colorize(:green)
    sleep 0.5
    puts "2. Add a new show."
    sleep 0.5
    puts "***********************************".colorize(:green)
    input = STDIN.gets.chomp
    puts ""
    if input == "1" && Event.all != []
        list_of_events
    elsif input == "1" && Event.all == []
        puts "You have no shows. Appease the rock gods and book some.".colorize(:red)
        welcome_back
    elsif input == "2"
        find_show
    elsif input == "exit"
        welcome_back
    else
        puts "Please enter the number corresponding to the option to continue.".colorize(:red)
        welcome_back
    end
end

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
            puts ""
            puts "Try a different event".colorize(:red)
            puts ""
            sleep 1
            find_event
        end
end

#-----------------------------------------------------------------------------------------------------------------------
# READING MY EVENTS

def list_of_events
    puts $new_user.my_shows.to_s
    puts "*********************************************".colorize(:green)
    puts "What would you like to do next?"
    sleep 1
    puts "---------------------------------------------".colorize(:green)
    sleep 0.5
    puts "1) Return to main menu"
    sleep 0.5
    puts "---------------------------------------------".colorize(:green)
    sleep 0.5
    puts "2) Delete event"
    sleep 0.5
    puts "---------------------------------------------".colorize(:green)
    sleep 0.5
    puts "3) Look at local shows to add a new event"
    sleep 0.5
    puts "*********************************************".colorize(:green)
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

def delete_event
    puts "Which event would you like to delete?"
    input = STDIN.gets.chomp.to_i
    if 
    show = Show.find(input)
    user = User.find($new_user.id)
    Event.where(show_id: show.id, user_id: user.id).destroy_all
    puts ""
    puts "Your show has been deleted.".colorize(:green)
    welcome_back
    else 
    "That show doesn't exist in your booked events.".colorize(:red)
    welcome_back
    end 
end 

#-----------------------------------------------------------------------------------------------------------------------
# Seed Shows From API 

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
#-----------------------------------------------------------------------------------------------------------------------
# Find Show

def find_show
    puts "Here are the shows currently avaliable in your area:"
    sleep 1
    puts tp Show.all
    sleep 2
    could_create_event
end

#-----------------------------------------------------------------------------------------------------------------------
#WOULD YOU LIKKE TO CREATE EVENT?

def could_create_event
    puts "-----------------------------------------------------------".colorize(:blue)
    sleep 0.5
    puts "Would you like to add one of these to your events?"
    sleep 1
    puts "**********************************************".colorize(:green)
    sleep 0.5
    puts "1) Yeah let's rock!"
    sleep 0.5
    puts "----------------------------------------------".colorize(:green)
    sleep 0.5
    puts "2) Read artist bios."
    sleep 0.5
    puts "----------------------------------------------".colorize(:green)
    sleep 0.5
    puts "3) Reprint list."
    sleep 0.5
    puts "----------------------------------------------".colorize(:green)
    sleep 0.5
    puts "4) No thank you, I'll return to the main menu."
    sleep 0.5
    puts "**********************************************".colorize(:green)
    input = STDIN.gets.chomp
    if input == "1"
        create_event
    elsif input == "2"
        all_artists_bios
    elsif input == "3"
        find_show
    elsif input == "4"
        welcome_back
    elsif input == "exit"
        welcome_back
    else
        puts "Please enter the number corresponding to the option to continue.".colorize(:red)
        could_create_event
    end
end

#-----------------------------------------------------------------------------------------------------------------------
#CREATE EVENT

def create_event
    puts ""
    puts "Which show would you like to add to your list of events?"
    input = STDIN.gets.chomp.to_i
    puts ""
    if input.between?(0,21) && $new_user.my_event_ids.each.exclude?(input)
        Event.create({user_id: $new_user.id, show_id: input, name: "Event"}) 
        puts ""
        puts ".".colorize(:red)
        sleep 0.5
        puts "..".colorize(:red)
        sleep 0.5
        puts "...".colorize(:red)
        sleep 0.5
        puts ""
        puts "The show has been added to your events list! Rock on!".colorize(:green)
        sleep 1
        puts "Sending you back to the main menu."
        sleep 1.5
        welcome_back
         elsif input == "exit"
            welcome_back
         else puts "Please enter a number between 1 and 20 or make sure the show isn't already in your events".colorize(:red)
            puts ""
            puts ""
            sleep 2
            find_show
    end


#-----------------------------------------------------------------------------------------------------------------------
#ALL ARTISTS

    def all_artists_bios
        sleep 0.5
        puts "Which artist you wanna get to know more about?"
        input = STDIN.gets.chomp
        if input == "1"
            sleep 1
            puts "----------------------------------BIO----------------------------------".colorize(:blue)
            puts "Anthony Santos, known professionally as Romeo Santos, is an American singer,"
            sleep 1
            puts "songwriter, actor, record producer, and former lead vocalist of the Bachata band Aventura." 
            sleep 1
            puts "In 2002, the song 'Obsesión' reached number one in Italy for 16 consecutive weeks." 
            sleep 1
            puts "He released several albums with Aventura before the group broke up."
            puts "-----------------------------------------------------------------------".colorize(:blue)
            sleep 3
            puts ""
            puts ".".colorize(:blue)
            sleep 0.5
            puts "..".colorize(:blue)
            sleep 0.5
            puts "...".colorize(:blue)
            sleep 0.5
            puts ""
            could_create_event
        elsif input == "2"
            puts ""
            could_create_event

        elsif input == "3"
            sleep 1
            puts "----------------------------------BIO----------------------------------".colorize(:blue)
            puts "Dead & Company is a band consisting of former Grateful Dead members Bob Weir," 
            sleep 1
            puts "Mickey Hart, and Bill Kreutzmann, along with John Mayer,"
            sleep 1
            puts "Oteil Burbridge, and Jeff Chimenti."
            sleep 1
            puts "-----------------------------------------------------------------------".colorize(:blue)
            sleep 3
            puts ""
            puts ".".colorize(:blue)
            sleep 0.5
            puts "..".colorize(:blue)
            sleep 0.5
            puts "...".colorize(:blue)
            sleep 0.5
            puts ""
            could_create_event

        elsif input == "4"
            sleep 1
            puts "----------------------------------BIO----------------------------------".colorize(:blue)
            puts "Dead & Company is a band consisting of former Grateful Dead members Bob Weir," 
            sleep 1
            puts "Mickey Hart, and Bill Kreutzmann, along with John Mayer,"
            sleep 1
            puts "Oteil Burbridge, and Jeff Chimenti."
            sleep 1
            puts "-----------------------------------------------------------------------".colorize(:blue)
            sleep 3
            puts ""
            puts ".".colorize(:blue)
            sleep 0.5
            puts "..".colorize(:blue)
            sleep 0.5
            puts "...".colorize(:blue)
            sleep 0.5
            puts ""
            could_create_event

        elsif input == "5"
            puts sleep 1
            puts "----------------------------------BIO----------------------------------".colorize(:blue)
            puts "Loud 25 is a one day music festival with guests including the likes of"
            sleep 1
            puts "Wu-Tang Clan, Three-Six Mafia, Fat Joe, Xzibit, and more."
            sleep 1
            puts "-----------------------------------------------------------------------".colorize(:blue)
            sleep 3
            puts ""
            puts ".".colorize(:blue)
            sleep 0.5
            puts "..".colorize(:blue)
            sleep 0.5
            puts "...".colorize(:blue)
            sleep 0.5
            puts ""
            could_create_event

        elsif input == "6"
            puts sleep 1
            puts "----------------------------------BIO----------------------------------".colorize(:blue)
            puts "Two Door Cinema Club are a Northern Irish indie rock band from" 
            sleep 1
            puts "Bangor and Donaghadee, County Down. The band formed in 2007 and is"
            sleep 1
            puts "composed of three members: Alex Trimble, Sam Halliday, and Kevin Baird."
            sleep 1
            puts "-----------------------------------------------------------------------".colorize(:blue)
            sleep 3
            puts ""
            puts ".".colorize(:blue)
            sleep 0.5
            puts "..".colorize(:blue)
            sleep 0.5
            puts "...".colorize(:blue)
            sleep 0.5
            puts ""
            could_create_event

        elsif input == "7"
            puts sleep 1
            puts "----------------------------------BIO----------------------------------".colorize(:blue)
            puts "José Álvaro Osorio Balvín is a Colombian reggaeton singer." 
            sleep 1
            puts "Balvin was born in Medellín, Colombia. At age 17, he moved to the United States."
            sleep 1
            puts "He moved to Oklahoma and New York to learn English"
            sleep 1
            puts "and was influenced by the music he heard there."
            sleep 1
            puts "-----------------------------------------------------------------------".colorize(:blue)
            sleep 3
            puts ""
            puts ".".colorize(:blue)
            sleep 0.5
            puts "..".colorize(:blue)
            sleep 0.5
            puts "...".colorize(:blue)
            sleep 0.5
            puts ""
            could_create_event

        elsif input == "8"
            puts sleep 1
            puts "----------------------------------BIO----------------------------------".colorize(:blue)
            puts "Lara Sophie Katy Crokaert, better known as Lara Fabian, is a Canadian-Belgian singer,"
            sleep 1
            puts "songwriter, musician, actress and producer. She has sold over 20 million records worldwide"
            sleep 1
            puts "as of September 2017 and is one of the best-selling Belgian artists of all time."
            sleep 1
            puts "-----------------------------------------------------------------------".colorize(:blue)
            sleep 3
            puts ""
            puts ".".colorize(:blue)
            sleep 0.5
            puts "..".colorize(:blue)
            sleep 0.5
            puts "...".colorize(:blue)
            sleep 0.5
            puts ""
            could_create_event

        elsif input == "9"
            puts sleep 1
            puts "----------------------------------BIO----------------------------------".colorize(:blue)
            puts "Backstreet Boys is an American vocal group, formed in Orlando, Florida in 1993."
            sleep 1
            puts "The group consists of AJ McLean, Howie Dorough, Nick Carter, Kevin Richardson,"
            sleep 1
            puts "and Brian Littrell. The group rose to fame with their debut" 
            sleep 1
            puts "international album, Backstreet Boys."
            sleep 1
            puts "-----------------------------------------------------------------------".colorize(:blue)
            sleep 3
            puts ""
            puts ".".colorize(:blue)
            sleep 0.5
            puts "..".colorize(:blue)
            sleep 0.5
            puts "...".colorize(:blue)
            sleep 0.5
            puts ""
            could_create_event

        elsif input == "10"
            puts sleep 1
            puts "----------------------------------BIO----------------------------------".colorize(:blue)
            puts "Sir Elton Hercules John CBE is an English singer, songwriter, pianist, and composer."
            sleep 1
            puts "He has worked with lyricist Bernie Taupin since 1967; they have collaborated"
            sleep 1
            puts "on more than 30 albums. John has sold more than 300 million records, making him" 
            sleep 1
            puts "one of the world's best-selling music artists."
            sleep 1
            puts "-----------------------------------------------------------------------".colorize(:blue)
            sleep 3
            puts ""
            puts ".".colorize(:blue)
            sleep 0.5
            puts "..".colorize(:blue)
            sleep 0.5
            puts "...".colorize(:blue)
            sleep 0.5
            puts ""
            could_create_event

        elsif input == "11"
            puts sleep 1
            puts "----------------------------------BIO----------------------------------".colorize(:blue)
            puts "Gloria Trevi is a Mexican singer-songwriter, dancer, actress,"
            sleep 1
            puts "television hostess, music video director and businesswoman."
            sleep 1
            puts "-----------------------------------------------------------------------".colorize(:blue)
            sleep 3
            puts ""
            puts ".".colorize(:blue)
            sleep 0.5
            puts "..".colorize(:blue)
            sleep 0.5
            puts "...".colorize(:blue)
            sleep 0.5
            puts ""
            could_create_event

        elsif input == "12"
            puts sleep 1
            puts "----------------------------------BIO----------------------------------".colorize(:blue)
            puts "Kiss is an American rock band formed in New York City in January 1973"
            sleep 1
            puts "by Paul Stanley, Gene Simmons, Peter Criss, and Ace Frehley."
            sleep 1
            puts "-----------------------------------------------------------------------".colorize(:blue)
            sleep 3
            puts ""
            puts ".".colorize(:blue)
            sleep 0.5
            puts "..".colorize(:blue)
            sleep 0.5
            puts "...".colorize(:blue)
            sleep 0.5
            puts ""
            could_create_event

        elsif input == "13"
            puts sleep 1
            puts "----------------------------------BIO----------------------------------".colorize(:blue)
            puts "The Jonas Brothers are an American pop rock band. Formed in 2005,"
            sleep 1
            puts "they gained popularity from their appearances on the Disney Channel" 
            sleep 1
            puts "television network. They consist of three brothers: Kevin Jonas, Joe Jonas, and Nick Jonas."
            sleep 1
            puts "-----------------------------------------------------------------------".colorize(:blue)
            sleep 3
            puts ""
            puts ".".colorize(:blue)
            sleep 0.5
            puts "..".colorize(:blue)
            sleep 0.5
            puts "...".colorize(:blue)
            sleep 0.5
            puts ""
            could_create_event

        elsif input == "14"
            puts sleep 1
            puts "----------------------------------BIO----------------------------------".colorize(:blue)
            puts "Sung Si-kyung is a South Korean singer and television host."
            sleep 1
            puts "He debuted in 2001 and has released seven studio albums in Korean and"
            sleep 1
            puts "two studio albums in Japanese. He has also hosted and appeared on numerous" 
            sleep 1
            puts "South Korean variety television shows including 2 Days & 1 Night, Witch Hunt, and Non-Summit."
            sleep 1
            puts "-----------------------------------------------------------------------".colorize(:blue)
            sleep 3
            puts ""
            puts ".".colorize(:blue)
            sleep 0.5
            puts "..".colorize(:blue)
            sleep 0.5
            puts "...".colorize(:blue)
            sleep 0.5
            puts ""
            could_create_event

        elsif input == "15"
            puts sleep 1
            puts "----------------------------------BIO----------------------------------".colorize(:blue)
            puts "In This Moment is an American metal band from Los Angeles, California,"
            sleep 1
            puts "formed by singer Maria Brink and guitarist Chris Howorth in 2005." 
            sleep 1
            puts "They found drummer Jeff Fabb and started the band as Dying Star."
            sleep 1
            puts "-----------------------------------------------------------------------".colorize(:blue)
            sleep 3
            puts ""
            puts ".".colorize(:blue)
            sleep 0.5
            puts "..".colorize(:blue)
            sleep 0.5
            puts "...".colorize(:blue)
            sleep 0.5
            puts ""
            could_create_event

        elsif input == "16"
            puts sleep 1
            puts "----------------------------------BIO----------------------------------".colorize(:blue)
            puts "Sir Elton Hercules John CBE is an English singer, songwriter, pianist, and composer."
            sleep 1
            puts "He has worked with lyricist Bernie Taupin since 1967; they have collaborated"
            sleep 1
            puts "on more than 30 albums. John has sold more than 300 million records, making him" 
            sleep 1
            puts "one of the world's best-selling music artists."
            sleep 1
            puts "-----------------------------------------------------------------------".colorize(:blue)
            sleep 3
            puts ""
            puts ".".colorize(:blue)
            sleep 0.5
            puts "..".colorize(:blue)
            sleep 0.5
            puts "...".colorize(:blue)
            sleep 0.5
            puts ""
            could_create_event

        elsif input == "17"
            puts sleep 1
            puts "----------------------------------BIO----------------------------------".colorize(:blue)
            puts "The Aquabats are an American rock band formed in Orange County, California in 1994." 
            sleep 1
            puts "Throughout many fluctuations in the group's line-up, singer The MC Bat Commander" 
            sleep 1
            puts "and bassist Crash McLarson have remained the band's two constant fixtures."
            sleep 1
            puts "-----------------------------------------------------------------------".colorize(:blue)
            sleep 3
            puts ""
            puts ".".colorize(:blue)
            sleep 0.5
            puts "..".colorize(:blue)
            sleep 0.5
            puts "...".colorize(:blue)
            sleep 0.5
            puts ""
            could_create_event

        elsif input == "18"
            puts sleep 1
            puts "----------------------------------BIO----------------------------------".colorize(:blue)
            puts "Tame Impala is an Australian psychedelic music project led by multi-instrumentalist"
            sleep 1
            puts "Kevin Parker, who writes, records, performs, and produces the music."
            sleep 1
            puts "As a touring act, Parker plays alongside Dominic Simper and some members"
            sleep 1
            puts "of Australian psychedelic rock band Pond – Jay Watson, Cam Avery, and Julien Barbagallo."
            sleep 1
            puts "-----------------------------------------------------------------------".colorize(:blue)
            sleep 3
            puts ""
            puts ".".colorize(:blue)
            sleep 0.5
            puts "..".colorize(:blue)
            sleep 0.5
            puts "...".colorize(:blue)
            sleep 0.5
            puts ""
            could_create_event

        elsif input == "19"
            puts sleep 1
            puts "----------------------------------BIO----------------------------------".colorize(:blue)
            puts "The Aquabats are an American rock band formed in Orange County, California in 1994." 
            sleep 1
            puts "Throughout many fluctuations in the group's line-up, singer The MC Bat Commander" 
            sleep 1
            puts "and bassist Crash McLarson have remained the band's two constant fixtures."
            sleep 1
            puts "-----------------------------------------------------------------------".colorize(:blue)
            sleep 3
            puts ""
            puts ".".colorize(:blue)
            sleep 0.5
            puts "..".colorize(:blue)
            sleep 0.5
            puts "...".colorize(:blue)
            sleep 0.5
            puts ""
            could_create_event

        elsif input == "20"
            puts sleep 1
            puts "----------------------------------BIO----------------------------------".colorize(:blue)
            puts "The Jonas Brothers are an American pop rock band. Formed in 2005,"
            sleep 1
            puts "they gained popularity from their appearances on the Disney Channel" 
            sleep 1
            puts "television network. They consist of three brothers: Kevin Jonas, Joe Jonas, and Nick Jonas."
            sleep 1
            puts "-----------------------------------------------------------------------".colorize(:blue)
            sleep 3
            puts ""
            puts ".".colorize(:blue)
            sleep 0.5
            puts "..".colorize(:blue)
            sleep 0.5
            puts "...".colorize(:blue)
            sleep 0.5
            puts ""
            could_create_event

        else
            puts "Please enter a number associated with an artist on the table.".colorize(:red)
            sleep 1
            all_artists_bios
        end
    end

end #app end