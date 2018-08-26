# frozen_string_literal: true

review_texts = [
  "Amazing. Takes great pictures! It has lots of settings to play with. Comes out instantly.",
  "I would consider this camera one of my best rentals of all time. I am totally in love with every photo that I take with it. It's very easy to operate and absolutely worth it. I try to use it as often as I can! ♥",
  "Nostalgically fabulous!!! SO cute. And retro looking... Even though no old camera ever looked like this.",
  "I love how raw the pictures look :) don't expect them to look HD with perfect lighting like your phone provides: but authentic and real.",
  "Honesty, this is the best camera film i ever had. I don't know why people complain about its exposure and all.",
  "This cute camera came in really fast in perfect condition. Pretty straight forward on how to use it and fun to capture memories to be cherished forever, right there on the spot.",
  "I just wanna say that I love this! I just take pictures of everything. I even took a pic of my door and let me just say that this camera just made my door look like an awesome door.",
  "Overall this camera is a solid performer. It is a jack of all trades. Photos to video, it does a dang decent job on it all with a big emphasis on the video side of things.",
  "Plus, it's easy on the shoulder, nails focus in most situations, captures impressive images and video and is an ideal travel and hiking DSLR.",
  "I was on the fence with renting this as I had the 60D as my 2nd camera, and didn't know if this would worth the extra cost to upgrade, but it was and is. I LOVE this camera.",
  "There's so much to love about this camera that deciding where to start is a challenge.",
  "I also really like the articulated touch screen, it is so convenient!",
  "This camera has amazing ISO. I spent Christmas at a relative's house with a new baby. Unfortunately, the whole house was dimly lit, so I was glad the 70D had some great ISO.",
  "I am in Love with this Camera!!!",
  "Loving this camera body. Low-light performance isn't on par with a full-frame camera of course, but it does well enough for my needs.",
  "This is a great camera. A good balance of the latest technology and affordability.",
  "One of the best things is it focuses on the fly while you are taking movies, which is generally unprecedented.",
  "Love the quality of the images and the autofocus seems to be nearly flawless at finding and tracking moving subjects (like dancers and athletes).",
  "It's more than a beginner's camera. If you have mastered other cameras, you can probably pick this up with no problem.",
  "I am a new youtube / blogger and wanted to pic upgrade the quality of the video on my channel and on my webpage. Also be able to take awesome pictures of family and life experiences.",
  "Absolutely love this camera!",
  "I love this camera so much. I can't tell you how much research I did on finding the right DSLR for my filming.",
  "I am a professional videographer by trade and this is my go to camera. I have not come across another DSLR that has such a great continuous video autofocus system.",
  "This Camera I perfect for action photography it is super fast and the autofocus is always right on.",
  "Love love love this camera! Finally a love view option! I use this feature a lot. It has many pros.",
  "Great camera with very good features. I shoot 99% still pics, but the video quality is great and the auto focus in video mode is impressive, things seem to just immediately snap into focus.",
  "Feature filled and yet still easy to use. The touch screen makes on-th-fly changes easy. The variety of focusing and exposure options provides great flexibility in controlling the image.",
  "Great all around camera. I'm a hobbyist but I do a lot of live shows for free entry and beer. I wish it was better in the dark as the autofocus has some issues in low light but that is what the big boy full frames are for.",
  "Excellent camera. Feels good and sturdy, very responsive.",
  "Service was excellent! Thanks!",
  "Outstanding Experience!",
  "Thank you so much. Pleasure working with you.",
  "Good Experience!",
  "Looking forward to work with again. Happy days!",
  "Outstanding Experience!",
  "Amazing!!! Fast and amazing!!! really!!! very appreciated!",
  "Thank you so much. Much better than I expected, good communication and delivery in less than 12 hours.",
  "I am happy with your service, Working on other store will get back to you soon. Great work.",
  "Thank you for your kind cooperation. Please working with you.",
  "This seller is Very professional and Super creative. Always A++ work",
  "Great experience! Top lessee! :)",
  "Great communication with lessee! I'll be back!",
  "My go-to guy from now on. This was a FANTASTIC experience all around.",
  "My experience with the seller was very good.",
  "Thank you for your amazing service I've come back to you twice and recommend you highly to friends and family.. thank you for your brilliant work..",
  "Perfect! Thanks again I will be back soon & suggest you to friends!!",
  "Amazing.. someone who cares about his clients needs! Highly recommended & will use again!!",
  "Great communication, the whole process was very smooth! Thank you!",
  "Thank you so much. Pleasure working with you!",
  "Thank you everything was Perfect",
  "Good Experience!",
  "He is very professional, detail oriented and have great patience and communication skills. He is tireless in delivering the best.",
  "Very friendly and thoughtful, always assisted us with our ideas. We would recommend and come again!",
  "Responded quickly and delivered on time and with amazing quality.",
  "Excellent experience and clear communications! Thank you! Looking forward to working with you again.",
  "Absolutely amazing! Nice work. Will order again for sure!",
  "Superb experience. Will recommend to other as well.",
  "Excellent experience and clear communications! Thank you!",
  "AWESOME! AWESOME! AWESOME! WEPERFECTIONIST ROCKS! I'll be using him again.",
]

photo_urls = [
  "https://images.unsplash.com/photo-1491830356944-3e5642d6517f?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=625ba174a0fb2c8995db8a5d9329d4be&auto=format&fit=crop&w=1500&q=80"
]

detail_desc = [
  "Designed for use with Instax Mini line of cameras
  Develops Instantly - Press the shutter, capture the moment, and watch the photo slide out and the image develop in front of your eyes!
  Hi-Speed ISO 800 - With superb grain quality, Instax Mini Film ensure vibrant color and natural skin tones.
  Credit-Card Size - 5.4 x 8.6 cm (film size) - The unique credit-card sized film is easy to carry in your purse or wallet and has that classic white frame that you can leave blank or personalize with fun messages.
  Easy-to-Load Cartridge - Film cartridge is designed and labeled for easy loading and filled with film for 10 credit-card sized instant prints.",
  "Stunning 4K video and 12MP photos in Single, Burst and Time Lapse modes.
  Durable by design, HERO5 Black is waterproof to 33ft (10m) without a housing
  Additional GoPro HERO5 Black Features + Benefits below on item page.
  Preview and playback your shots, change settings and trim your footage, all on your GoPro.",
  "Long 20X zoom draws in the scene from far away
  Exclusive high-dynamic range feature reduces bright spots for a professional look
  Wirelessly connect your smartphone’s video camera for a picture-in-picture video effect",
  "18 megapixel CMOS (APS-C) sensor with DIGIC 4 image processor
  EF-S 18-55mm IS II standard zoom lens expands picture-taking possibilities
  3-inch LCD TFT color, liquid-crystal monitor for easy viewing and sharing
  EOS 1080p full HD movie mode helps you capture brilliant results
  Features include continuous shooting up to 3fps, Scene Intelligent Auto mode, creative filers, built-in flash and feature guide",
  "18 megapixel CMOS (APS-C) sensor with DIGIC 4 image processor
  EF-S 18-55mm IS II standard zoom lens expands picture-taking possibilities
  3-inch LCD TFT color, liquid-crystal monitor for easy viewing and sharing. EOS 1080p full HD movie mode helps you capture brilliant results.
  Features include continuous shooting up to 3fps, Scene Intelligent Auto mode, creative filers, built-in flash and feature guide",
  "24.2MP APS-C Exmor sensor w/ advanced processing up to ISO 51.200
  Wide 425 phase detection AF points, Fast 0.05 sec. AF acquisition
  5-axis in-body image stabilization steadies every lens
  11fps continuous shooting to 269 frames at 24.2MP w/ AE/AF tracking
  4K movie w/ 2.4x oversampling4, full pixel readout, no pixel binning",
  "24 MP APS-C CMOS sensor
  ISO 100-25600 (expandable to 51200)
  Hybrid AF with 179-point focal plane phase-detection and 25 contrast detect points
  Up to 11 FPS continious shooting
  3-inch tilting LCD with 921,000 dots
  OLED electronic viewfinder with 100% coverage and 1.4 million dots
  Built-in Wi-Fi and NFC",
]

User.create(username: "Guest", password: "password")

50.times do
  User.create(username: Faker::Name.name, password: "password")
end

%w[Photography DSLR Video Accessories Location
   Lighting Sound Lenses Filters].each do |category|
  Category.create(name: category)
end

%w[Canon Nikon Fuji Sony Pentax Leica Minolta Panasonic].each do |brand|
  Brand.create(name: brand)
end

150.times do
  Listing.create(
    lessor: User.find(rand(1..User.count)),
    listing_title: Faker::Company.buzzword,
    detail_desc: detail_desc.sample,
    location: "#{Faker::Address.street_address}, #{Faker::Address.city}",
    lat: Faker::Address.latitude,
    lng: Faker::Address.longitude,
    day_rate: rand(5..500),
    replacement_value: rand(500..5000),
    serial: Faker::Crypto.md5,
    brand: Brand.find(rand(1..Brand.count)),
    category: Category.find(rand(1..Category.count)),
    active: true,
  )
end

30.times do
  Listing.create(
    lessor: User.find(rand(1..User.count)),
    listing_title: Faker::Company.buzzword,
    detail_desc: detail_desc.sample,
    location: "#{Faker::Address.street_address}, #{Faker::Address.city}",
    lat: rand(37.711537399325096..37.77940697341724),
    lng: rand(-122.47692206127931..-122.40310766918947),
    day_rate: rand(5..500),
    replacement_value: rand(500..5000),
    serial: Faker::Crypto.md5,
    brand: Brand.find(rand(1..Brand.count)),
    category: Category.find(rand(1..Category.count)),
    active: true,
  )
end

30.times do
  Listing.create(
    lessor: User.find(rand(1..User.count)),
    listing_title: Faker::Company.buzzword,
    detail_desc: detail_desc.sample,
    location: "#{Faker::Address.street_address}, #{Faker::Address.city}",
    lat: rand(40.59453229604209..40.72475342512843),
    lng: rand(-74.0213908239258..-73.87376203974611),
    day_rate: rand(5..500),
    replacement_value: rand(500..5000),
    serial: Faker::Crypto.md5,
    brand: Brand.find(rand(1..Brand.count)),
    category: Category.find(rand(1..Category.count)),
    active: true,
  )
end

30.times do
  Listing.create(
    lessor: User.first,
    listing_title: Faker::Company.buzzword,
    detail_desc: detail_desc.sample,
    location: "#{Faker::Address.street_address}, #{Faker::Address.city}",
    lat: rand(30.59453229604209..47.59453229604209),
    lng: rand(-113.59453229604209..-94.59453229604209),
    day_rate: rand(5..500),
    replacement_value: rand(500..5000),
    serial: Faker::Crypto.md5,
    brand: Brand.find(rand(1..Brand.count)),
    category: Category.find(rand(1..Category.count)),
    active: true,
  )
end

1000.times do
  starting_date = Faker::Date.forward(150)
  ending_date = starting_date + rand(1..14)

  Rental.create(
    listing: Listing.find(rand(1..Listing.count)),
    lessee: User.find(rand(1..User.count)),
    start_date: starting_date,
    end_date: ending_date,
  )
end

30.times do
  starting_date = Faker::Date.forward(150)
  ending_date = starting_date + rand(1..14)

  Rental.create(
    listing: Listing.find(rand(1..Listing.count)),
    lessee: User.first,
    start_date: starting_date,
    end_date: ending_date,
  )
end

Listing.count.times do |i|
  12.times do
    Photo.create(
      listing: Listing.find(i + 1),
      image_url: photo_urls.sample,
    )
  end
end

Rental.count.times do |i|
  next if Rental.find(i + 1).lessee.id == 1
  Review.create(
    rental: Rental.find(i + 1),
    review: [1, 2, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 5].sample,
    review_text: review_texts.sample,
  )
end
