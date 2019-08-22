class Show < ActiveRecord::Base
    has_many :events
    has_many :users, through: :events
end

def list_of_show_ids
    Show.all.select do |show|
        Show.id 
    end 
end