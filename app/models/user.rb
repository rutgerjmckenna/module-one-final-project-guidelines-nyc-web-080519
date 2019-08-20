class User < ActiveRecord::Base
    has_many :events
    has_many :shows, through: :events
end