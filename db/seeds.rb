# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#require 'faker'

#for i in 1..100 do 
#	date = Faker::Date.between(from: '2010-09-23', to: '2021-09-25')
#    User.create!(
#    email: Faker::Internet.unique.email,
#    password: "1234567",
#    created_at: date,
#	updated_at: date
#  )
#  #user.save!
#end

require 'csv'
 
User.transaction do
   users = CSV.read("#{Rails.root}/FakeDataGenerator/users.csv")
   columns = [:email, :encrypted_password, :created_at, :updated_at]
   User.import columns, users, validate: false
end



Vlog.transaction do
   users = CSV.read("#{Rails.root}/FakeDataGenerator/vlogs.csv")
   columns = [:title, :content, :created_at, :updated_at, :user_id]
   Vlog.import columns, users, validate: false
end

#for i in 1..10 do
#	date = Faker::Date.between(from: '2010-09-23', to: '2021-09-25')
#	Vlog.create(
#		title: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4),
#		content: Faker::Lorem.paragraph(sentence_count: 6, supplemental: true, random_sentences_to_add: 4),
#		created_at: date,
#		updated_at: date,
#    	user_id: rand(1..100)
#    )
#  
#end

Comment.transaction do
   users = CSV.read("#{Rails.root}/FakeDataGenerator/comments.csv")
   columns = [:comment, :vlog_id, :user_id, :created_at, :updated_at]
   Comment.import columns, users, validate: false
end
#for i in 1..100 do
#	date = Faker::Date.between(from: '2010-09-23', to: '2021-09-25')
#	Comment.create(
#		comment: Faker::Lorem.sentence(word_count: 20, supplemental: false, random_words_to_add: 10),
#    	vlog_id: rand(1..100),
#    	user_id: rand(1..100),
#    	created_at: date,
#		updated_at: date,
#		)
#end

#for i in 1..100 do
#	date = Faker::Date.between(from: '2010-09-23', to: '2021-09-25')
#	Like.create(
#    	vlog_id: rand(1..100),
#    	user_id: rand(1..100),
#    	created_at: date,
#		updated_at: date,
#		)
#end

Like.transaction do
   users = CSV.read("#{Rails.root}/FakeDataGenerator/likes.csv")
   columns = [:vlog_id, :user_id, :created_at, :updated_at]
   Like.import columns, users, validate: false
end


