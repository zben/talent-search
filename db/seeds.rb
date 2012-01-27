# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
    
    ActiveRecord::Base.transaction do
      User.delete_all
      Profile.delete_all
      Usage.delete_all
      20.times do
      
        x=User.create({
          email: Faker::Internet.email,
          password: 'password',
          type_id: 1,
        })
      end
    end
    ActiveRecord::Base.transaction do
      User.all.each do |user|
        user.profile = Profile.create({
          firstname: Faker::Name.first_name,
          lastname: Faker::Name.last_name,
          birthday: Date.new(1990-Random.rand(20),Random.rand(11)+1,Random.rand(20)+1),
          gender: Random.rand(2)+1,
          citizenship: Random.rand(2)+1,
          residence_country: Random.rand(2)+1,
          intro: Faker::Lorem.paragraph,
          intro_title: Faker::Lorem.sentence
        })
        user.skills << Skill.order("RANDOM()").limit(6)
        user.usage = Usage.create({find_job:true,find_project: Random.rand(2)==1,find_partner: Random.rand(2)==1, find_money: Random.rand(2)==1})
        
      end
    end
