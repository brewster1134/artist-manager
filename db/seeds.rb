# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# CHANGE THESE!  # TODO: make email generic here and in settings.yml
u = User.create(
  username:              'brewster',
  email:                 'brewster@wearemanalive.com',
  password:              'password',
  password_confirmation: 'password'
)
puts "USER CREATED:"
puts "  #{u.username} / #{u.email}"
