# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

  User.create!(
     email: Faker::Internet.email,
     password: Faker::Internet.password
  )
  
  Wiki.create!(
      title:   Faker::HarryPotter.book,
      body:    Faker::HarryPotter.quote,
      private: Faker::Boolean.boolean
  )
  
  User.create!(
    email: "test_admin@gmail.com",
    password: "abcd@1234",
    role: "admin"
    )
  
  puts "#{User.count} users created"
  puts "#{User.all}"
  puts "#{Wiki.count} wikis created"
  puts "#{Wiki.all}"
  
  
