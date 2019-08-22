require 'pry'
class User < ActiveRecord::Base
    has_many :events
    has_many :shows, through: :events
    
def my_events
    my_events = Event.all.select do |e|
       e.user_id == $new_user.id
    end
end 

def my_event_ids
    my_ids = []
    my_events.each do |event|
        my_ids << event.show_id
    end
    my_ids
end

def my_shows
    my_shows = my_events.map do |event|
        Show.all[event.show_id-1]
    end 
    tp my_shows
    puts ""
end

end #class end