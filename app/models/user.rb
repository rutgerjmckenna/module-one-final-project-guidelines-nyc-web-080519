require 'pry'
class User < ActiveRecord::Base
    has_many :events
    has_many :shows, through: :events

def my_events
    my_events = Event.all.select do |e|
       e.user_id == @@new_user.id
    end
end 

def my_shows
    my_shows = my_events.map do |event|
        Show.all[event.show_id-1]
    end 
    puts tp my_shows, :name, :city, :state, :venue, :locate_date, :locate_time, :genre
end

# def list_my_event_ids
# my_events.select do |event|
#     event.show_id
# end 

# Show.all.select do |show|
#     Show.id == list_my_event_ids
# end 

end #class end