# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.create(title: "South Park",
            description: "The ongoing narrative of four boys — Stan Marsh, Kyle Broflovski, Eric Cartman and Kenny McCormick — and their bizarre adventures in and around the titular Colorado town.",
            small_cover_url: "south_park",
            large_cover_url: "south_park_large",
            category_id: 2)
monk = Video.create(title: "Monk",
            description: "A detective mystery television series created by Andy Breckman and starring Tony Shalhoub as the eponymous character, Adrian Monk.",
            small_cover_url: "monk",
            large_cover_url: "monk_large",
            category_id: 1)
futurama = Video.create(title: "Futurama",
            description: "The series follows the adventures of a late-20th-century New York City pizza delivery boy, Philip J. Fry, who, after being unwittingly cryogenically frozen for one thousand years, finds employment at Planet Express, an interplanetary delivery company in the retro-futuristic 31st century.",
            small_cover_url: "futurama",
            large_cover_url: "futurama_large",
            category_id: 2)
breaking_bad = Video.create(title: "Breaking Bad",
            description: "The story of Walter White (Bryan Cranston), a struggling high school chemistry teacher who is diagnosed with inoperable lung cancer at the beginning of the series. He turns to a life of crime, producing and selling methamphetamine with a former student.",
            small_cover_url: "breaking_bad",
            large_cover_url: "breaking_bad_large",
            category_id: 1)
Video.create(title: "Firefly",
            description: "The series is set in the year 2517, after the arrival of humans in a new star system, and follows the adventures of the renegade crew of Serenity, a 'Firefly-class' spaceship.",
            small_cover_url: "firefly",
            large_cover_url: "firefly_large",
            category_id: 3)

Category.create(name: "TV Dramas")
Category.create(name: "TV Comedies")
Category.create(name: "TV Science Fiction")

josh = User.create(full_name: "Josh Scanish", email: "josh@example.com", password: "josh")
jason = User.create(full_name: "Jason S", email: "jason@example.com", password: "jason")
steph = User.create(full_name: "Steph S", email: "steph@example.com", password: "steph")

Review.create(user: josh, video: monk, rating: 3, content: "A really good show!")
Review.create(user: josh, video: monk, rating: 2, content: "An ok show")

QueueItem.create(user: jason, video: monk, position: 1)
QueueItem.create(user: jason, video: futurama, position: 2)
QueueItem.create(user: josh, video: breaking_bad, position: 1)

josh.follower_relationships << Following.create(follower_id: josh.id, followee_id: jason.id)
josh.follower_relationships << Following.create(follower_id: josh.id, followee_id: steph.id)
jason.follower_relationships << Following.create(follower_id: jason.id, followee_id: josh.id)
jason.follower_relationships << Following.create(follower_id: jason.id, followee_id: steph.id)
steph.follower_relationships << Following.create(follower_id: steph.id, followee_id: josh.id)


