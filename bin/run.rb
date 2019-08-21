require_relative '../config/environment'
ActiveRecord::Base.logger.level=1

def run_app
    greeting
end 

run_app
