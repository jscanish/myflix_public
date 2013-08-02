# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.create(title: "Firefly", description: "A sci fi show", small_cover_url: "src=/tmp/firefly.jpg", large_cover_url: "src=/tmp/firefly.jpg")
Video.create(title: "The Wire", description: "A police drama", small_cover_url: "/tmp/the_wire.jpg", large_cover_url: "/tmp/the_wire.jpg")
Video.create(title: "Avatar: The Last Airbender", description: "A cartoon", small_cover_url: "/tmp/avatar_airbender.jpg", large_cover_url: "/tmp/avatar_airbender.jpg")
