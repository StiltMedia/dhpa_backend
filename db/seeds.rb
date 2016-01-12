# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

def image_size(path)
  magick = MiniMagick::Image.open path
  "#{magick.width}x#{magick.height}"
end

Setting.create commercial_price: 5000, personal_price: 2000, personal_image_size: 500 # $50, $20, and 500px

admin1 = User.create first_name: "Default", last_name: "Admin", email: "admin@example.com", password: "password", is_admin: true
user1 = User.create first_name: "Default", last_name: "User1", email: "user1@example.com", password: "password"

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

copy = "David Heischrek / DHPA.com"
assets_path = "app/assets/images/samples/"

event1 = Event.create title: "Lowline 2015", location: "Angel Orensanz Foundation, NYC", photographer: "Benjamin Lozovsky", date: "2015-10-21", sub_title: "Anti-Gala", slug: "lowline-2015", image_url: File.new(assets_path+'event1.jpg'), is_featured: true, is_top_featured: true, tag_list: "celebrity, gala, Angel Orensanz"

photo1 = Photo.create event: event1, file: File.new(assets_path+'event1.jpg'), copyright: copy, size: image_size(assets_path+'event1.jpg'), vips: [vip_a, vip_b], commercial_price: 9999, personal_price: 8888, tag_list: "Lorem, ipsum, dolor, sit, amet"
photo2 = Photo.create event: event1, file: File.new(assets_path+'event2.jpg'), copyright: copy, size: image_size(assets_path+'event2.jpg'), vips: [vip_c, vip_d], tag_list: "laboris, nisi, ut aliquip"
photo3 = Photo.create event: event1, file: File.new(assets_path+'event3.jpg'), copyright: copy, size: image_size(assets_path+'event3.jpg'), vips: [vip_e, vip_f], tag_list: "consectetur, adipiscing, elit"
photo4 = Photo.create event: event1, file: File.new(assets_path+'event4.jpg'), copyright: copy, size: image_size(assets_path+'event4.jpg'), vips: [vip_g, vip_h], tag_list: "sed, do, eiusmod, tempor, incididunt"
photo5 = Photo.create event: event1, file: File.new(assets_path+'event5.jpg'), copyright: copy, size: image_size(assets_path+'event5.jpg'), vips: [vip_a, vip_e], tag_list: "ut, labore, et dolore, magna, aliqua"
photo6 = Photo.create event: event1, file: File.new(assets_path+'event6.jpg'), copyright: copy, size: image_size(assets_path+'event6.jpg'), vips: [vip_b, vip_f], tag_list: "Ut, enim, ad minim, veniam"
photo7 = Photo.create event: event1, file: File.new(assets_path+'event7.jpg'), copyright: copy, size: image_size(assets_path+'event7.jpg'), vips: [vip_c, vip_g], tag_list: "quis, nostrud, exercitation, ullamco"
photo8 = Photo.create event: event1, file: File.new(assets_path+'event8.jpg'), copyright: copy, size: image_size(assets_path+'event8.jpg'), vips: [vip_d, vip_h], tag_list: "Lorem, ipsum, dolor, sit, amet"

event2 = Event.create title: "High Life 2016", location: "Sam's Hideaway, Los Angeles", photographer: "John Smith", date: "2015-11-13", sub_title: "The Redux", image_url: File.new(assets_path+'event2.jpg'), is_featured: true, tag_list: "California, caution tape, celebrity"

photo9 = Photo.create event: event2, file: File.new('doc/design/exif_examples/IMG_2480.jpg'), copyright: copy, size: "1200x800", vips: [vip_l,vip_m,vip_n], commercial_price: 7777, personal_price: 6666, tag_list: "commodo, consequat"
photo10 = Photo.create event: event2, file: File.new('doc/design/exif_examples/IMG_2482.jpg'), copyright: copy, size: "1200x800", vips: [vip_i,vip_j,vip_k], tag_list: "sunt in culpa, qui officia, deserunt"
photo11 = Photo.create event: event2, file: File.new(assets_path+'event10.jpg'), copyright: copy, size: image_size(assets_path+'event10.jpg'), vips: [vip_a, vip_e], tag_list: "in voluptate, velit, esse cillum"
photo12 = Photo.create event: event2, file: File.new(assets_path+'event11.jpg'), copyright: copy, size: image_size(assets_path+'event11.jpg'), vips: [vip_b, vip_f], tag_list: "dolore eu, fugiat nulla, pariatur"
photo13 = Photo.create event: event2, file: File.new(assets_path+'event12.jpg'), copyright: copy, size: image_size(assets_path+'event12.jpg'), vips: [vip_c, vip_g], tag_list: "Excepteur, sint occaecat"
photo14 = Photo.create event: event2, file: File.new(assets_path+'event13.jpg'), copyright: copy, size: image_size(assets_path+'event13.jpg'), vips: [vip_d, vip_h], tag_list: "cupidatat non, proident"
photo15 = Photo.create event: event2, file: File.new(assets_path+'event14.jpg'), copyright: copy, size: image_size(assets_path+'event14.jpg'), vips: [vip_g, vip_h], tag_list: "Lorem, ipsum, dolor, sit, amet"

event3 = Event.create title: "Christmas At The Apollo", location: "Apollo Theater, Birmingham", photographer: "David Heischrek", date: "2015-12-25", sub_title: "feat. Chris Rock", image_url: File.new(assets_path+'event5.jpg'), is_featured: true, is_top_featured: true, password: "password", tag_list: "christmas, Chris Rock, comedian, Alabama"

photo16 = Photo.create event: event3, file: File.new(assets_path+'featured1.jpg'), copyright: copy, size: image_size(assets_path+'event5.jpg'), vips: [vip_c, vip_h], commercial_price: 5555, personal_price: 4444, tag_list: "sunt in culpa, qui officia, deserunt"
photo17 = Photo.create event: event3, file: File.new(assets_path+'featured2.jpg'), copyright: copy, size: image_size(assets_path+'event6.jpg'), vips: [vip_d, vip_l], tag_list: "mollit anim id, est laborum"
photo18 = Photo.create event: event3, file: File.new(assets_path+'featured3.jpg'), copyright: copy, size: image_size(assets_path+'event7.jpg'), vips: [vip_g, vip_m], tag_list: "Lorem, ipsum, dolor, sit, amet"
photo19 = Photo.create event: event3, file: File.new(assets_path+'lightbox1.jpg'), copyright: copy, size: image_size(assets_path+'event11.jpg'), vips: [vip_a, vip_n], tag_list: "Lorem, ipsum, dolor, sit, amet"
photo20 = Photo.create event: event3, file: File.new(assets_path+'lightbox2.jpg'), copyright: copy, size: image_size(assets_path+'event12.jpg'), vips: [vip_b, vip_g], tag_list: "commodo, consequat"
photo21 = Photo.create event: event3, file: File.new(assets_path+'portrait.jpg'), copyright: copy, size: image_size(assets_path+'portrait.jpg'), vips: [vip_c, vip_h], tag_list: "Ut, enim, ad minim, veniam"

payment_info = PaymentInfo.create user: user1, brand: "Visa", exp_month: 12, exp_year: 17, last4: "4242"
order_shipping_info = OrderShippingInfo.create first_name: "John", last_name: "Smith", street: "123 Main St", city: "Phoenix", state: "AZ", zipcode: "85013", country: "USA"
order_contact_info = OrderContactInfo.create email: "test@zyphon.com"
order1 = Order.create user: user1, payment_info: payment_info, order_shipping_info: order_shipping_info, order_contact_info: order_contact_info

lineitem1 = LineItem.create photo: photo1, order: order1
DeliveryOption.create line_item: lineitem1, option_type: "digital", license: "Personal Use"

lightbox1 = Lightbox.create user: user1, name: "Christmas 2015"
lightbox1.photos << photo2
lightbox1.photos << photo5
lightbox1.photos << photo10
lightbox1.photos << photo17