### PASS IN A HASH ###

u1 = User.create(first_name: "Rutger", last_name: "McKenna", age: 28)


# s1 = Show.create({name: "Bebop and the Poops", city: "Witchitah", state: "KS", venue: "Lalaland", local_date: "2019-08-23", local_time: "18:00:00", genre: "crap"})
# s2 = Show.create({name:"Elton World Tour", city: "create York", state: "NY", venue: "Brooklyn Steel", local_date: "2019-08-25", local_time: "19:00:00", genre: "shit"})
# s3 = Show.create({name:"Backstreet Boys World Tour", city: "Paris", state: "TX", venue: "KCBC", local_date: "2019-08-26", local_time: "20:00:00", genre: "loud"})
# s4 = Show.create({name:"Beatles World Tour", city: "San Francisco", state: "CS", venue: "Jones Beach", local_date: "2019-08-27", local_time: "21:00:00", genre: "rock"})
# s5 = Show.create({name:"Fleetwood Mac World Tour", city: "Dallas", state: "TX", venue: "St. Vitus", local_date: "2019-08-28", local_time: "22:00:00", genre: "classic"})

# e1 = Event.create({user_id: u1.id , show_id: s1.id, name: s1.name})
# e2 = Event.create({user_id: u1.id , show_id: s2.id, name: s2.name})
# e3 = Event.create({user_id: u1.id , show_id: s3.id, name: s3.name})
# e4 = Event.create({user_id: u1.id , show_id: s4.id, name: s4.name})
# e5 = Event.create({user_id: u1.id , show_id: s5.id, name: s5.name})