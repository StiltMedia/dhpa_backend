# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Setting.create default_price: 2000 #$20.00

User.create email: "admin@example.com", password: "password", is_admin: true
User.create email: "user1@example.com", password: "password"

event1 = Event.create title: "Lowline 2015", location: "Angel Orensanz Foundation, NYC", photographer: "Benjamin Lozovsky", date: "2015-10-21", sub_title: "Anti-Gala", slug: "lowline-2015", image_url: File.new('app/assets/images/event1.jpg')

ActionController::Base.helpers.create_vips(event1)

Photo.create event: event1, file: File.new('app/assets/images/event1.jpg')
Photo.create event: event1, file: File.new('app/assets/images/event2.jpg')
Photo.create event: event1, file: File.new('app/assets/images/event3.jpg')
Photo.create event: event1, file: File.new('app/assets/images/event4.jpg')
Photo.create event: event1, file: File.new('app/assets/images/event5.jpg')
Photo.create event: event1, file: File.new('app/assets/images/event6.jpg')
Photo.create event: event1, file: File.new('app/assets/images/event7.jpg')
Photo.create event: event1, file: File.new('app/assets/images/event8.jpg')

event2 = Event.create title: "High Life 2016", location: "Sam's Hideaway, Los Angeles", photographer: "John Smith", date: "2015-11-13", sub_title: "The Redux", image_url: File.new('app/assets/images/event2.jpg')

Photo.create event: event2, file: File.new('app/assets/images/event10.jpg')
Photo.create event: event2, file: File.new('app/assets/images/event11.jpg')
Photo.create event: event2, file: File.new('app/assets/images/event12.jpg')
Photo.create event: event2, file: File.new('app/assets/images/event13.jpg')
Photo.create event: event2, file: File.new('app/assets/images/event14.jpg')