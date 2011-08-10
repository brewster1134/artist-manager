# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.create(
  username:              Settings.admin.username,
  email:                 Settings.admin.email,
  password:              Settings.admin.password,
  password_confirmation: Settings.admin.password  
)
puts "USER CREATED:"
puts "  #{u.username} / #{u.email}"
