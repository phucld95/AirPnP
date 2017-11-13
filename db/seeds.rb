p "seeding 50 users"
User.create! email: "airbnb@airbnb.com",
  password: "airbnb",
  reset_password_sent_at: "",
  remember_created_at: "",
  last_sign_in_at: "",
  current_sign_in_ip: "",
  last_sign_in_ip: "",
  fullname: "AirBnb"

49.times do |n|
  email = Faker::Internet.email
  User.create! email: email,
    password: "password",
    reset_password_sent_at: "",
    remember_created_at: "",
    last_sign_in_at: "",
    current_sign_in_ip: "",
    last_sign_in_ip: "",
    fullname: Faker::Name.name,
    description:Faker::Lorem.paragraphs
end

p "seeding 20 rooms"

20.times do |n|
  Room.create! listing_name: Faker::Name.title,
  home_type: ["Apartment", "House", "Bed & Breakfast"].sample,
  room_type: ["Entire", "Private", "Share"].sample,
  accommodate: rand(1..5),
  bed_room: rand(1..5),
  bath_room: rand(1..5),
  summary: Faker::Lorem.paragraphs,
  active: [true, false].sample,
  user_id: rand(1..50),
  is_tv: [true, false].sample,
  is_kitchen: [true, false].sample,
  is_air: [true, false].sample,
  is_heating: [true, false].sample,
  is_internet: [true, false].sample,
  price: rand(20..1000),
  address: Faker::Address.street_address
end

p "seeding 20 reservations"


p "seeding 6 cities"

City.create! name: "London",
  image: "http://www.gdcc.com/wp-content/uploads/2013/12/2-London.jpg"

City.create! name: "Beijing",
  image: "https://www.cathaypacific.com/content/dam/destinations/beijing/cityguide-gallery/beijing_modern_city_920x500.jpg"

City.create! name: "Cairo",
  image: "http://www.youregypttours.com/img/p/308-665.jpg"

City.create! name: "Paris",
  image: "https://travel.com.vn/images/destination/Large/dg_150723_Eiffel-Tower-Paris-France.jpg"

City.create! name: "New york",
  image: "https://images.pexels.com/photos/450597/pexels-photo-450597.jpeg?w=940&h=650&auto=compress&cs=tinysrgb"

City.create! name: "Kyoto",
  image: "https://i1.wp.com/media.boingboing.net/wp-content/uploads/2014/11/P14202493.jpg?w=970"

p "seeding 6 reviews"

for i in 1..20
  Review.create! comment: "Nice!", star: 5,room_id: i, user_id: i
  Review.create! comment: "Nice!", star: 3,room_id: i, user_id: 21 - i
end


