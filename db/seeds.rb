# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.create(
  username:              Settings.default_admin.username,
  email:                 Settings.default_admin.email,
  password:              Settings.default_admin.password,
  password_confirmation: Settings.default_admin.password  
)
puts "USER CREATED:"
puts "  #{u.username} / #{u.email}"
