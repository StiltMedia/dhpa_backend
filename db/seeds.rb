# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

Setting.create commercial_price: 5000, personal_price: 2000, personal_image_size: 500 # $50, $20, and 500px

User.create email: "admin@example.com", password: "password", is_admin: true
User.create email: "user1@example.com", password: "password"

vip_a = Vip.create name: 'John Smith'
vip_b = Vip.create name: 'Jane Doe'
vip_c = Vip.create name: 'Sam Smith'
vip_d = Vip.create name: 'Jim Doe'
vip_e = Vip.create name: 'Bill Smith'
vip_f = Vip.create name: 'Ted Doe'
vip_g = Vip.create name: 'Kim Smith'
vip_h = Vip.create name: 'David Doe'
vip_i = Vip.create name: 'Meredith Texeira'
vip_j = Vip.create name: 'Danny Jelaca'
vip_k = Vip.create name: 'Diego Gordon'
vip_l = Vip.create name: 'Esther Delgado'
vip_m = Vip.create name: 'Yury Rossi'
vip_n = Vip.create name: 'Claudia Orrett'

event1 = Event.create title: "Lowline 2015", location: "Angel Orensanz Foundation, NYC", photographer: "Benjamin Lozovsky", date: "2015-10-21", sub_title: "Anti-Gala", slug: "lowline-2015", image_url: File.new('app/assets/images/event1.jpg')

Photo.create event: event1, file: File.new('app/assets/images/event1.jpg'), copyright: "David Heischrek / DHPA.com", size: "300x200", vips: [vip_a, vip_b]
Photo.create event: event1, file: File.new('app/assets/images/event2.jpg'), copyright: "David Heischrek / DHPA.com", size: "300x200", vips: [vip_c, vip_d]
Photo.create event: event1, file: File.new('app/assets/images/event3.jpg'), copyright: "David Heischrek / DHPA.com", size: "300x200", vips: [vip_e, vip_f]
Photo.create event: event1, file: File.new('app/assets/images/event4.jpg'), copyright: "David Heischrek / DHPA.com", size: "300x200", vips: [vip_g, vip_h]
Photo.create event: event1, file: File.new('app/assets/images/event5.jpg'), copyright: "David Heischrek / DHPA.com", size: "300x200", vips: [vip_a, vip_e]
Photo.create event: event1, file: File.new('app/assets/images/event6.jpg'), copyright: "David Heischrek / DHPA.com", size: "300x200", vips: [vip_b, vip_f]
Photo.create event: event1, file: File.new('app/assets/images/event7.jpg'), copyright: "David Heischrek / DHPA.com", size: "300x200", vips: [vip_c, vip_g]
Photo.create event: event1, file: File.new('app/assets/images/event8.jpg'), copyright: "David Heischrek / DHPA.com", size: "300x200", vips: [vip_d, vip_h]

event2 = Event.create title: "High Life 2016", location: "Sam's Hideaway, Los Angeles", photographer: "John Smith", date: "2015-11-13", sub_title: "The Redux", image_url: File.new('app/assets/images/event2.jpg')

Photo.create event: event2, file: File.new('doc/design/exif_examples/IMG_2480.jpg'), copyright: "David Heischrek / DHPA.com", size: "1200x800", vips: [vip_l,vip_m,vip_n] #has exif
Photo.create event: event2, file: File.new('doc/design/exif_examples/IMG_2482.jpg'), copyright: "David Heischrek / DHPA.com", size: "1200x800", vips: [vip_i,vip_j,vip_k] #has exif
Photo.create event: event2, file: File.new('app/assets/images/event10.jpg'), copyright: "David Heischrek / DHPA.com", size: "300x200", vips: [vip_a, vip_e]
Photo.create event: event2, file: File.new('app/assets/images/event11.jpg'), copyright: "David Heischrek / DHPA.com", size: "300x200", vips: [vip_b, vip_f]
Photo.create event: event2, file: File.new('app/assets/images/event12.jpg'), copyright: "David Heischrek / DHPA.com", size: "300x200", vips: [vip_c, vip_g]
Photo.create event: event2, file: File.new('app/assets/images/event13.jpg'), copyright: "David Heischrek / DHPA.com", size: "300x200", vips: [vip_d, vip_h]
Photo.create event: event2, file: File.new('app/assets/images/event14.jpg'), copyright: "David Heischrek / DHPA.com", size: "300x200", vips: [vip_g, vip_h]