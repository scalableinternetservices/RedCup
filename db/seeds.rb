# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

for i in 1..5 do 
    user=User.new(
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password
  )
  user.save!
end

for i in 1..10 do
	Vlog.create(
		title: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4),
		content: Faker::Lorem.paragraph(sentence_count: 6, supplemental: true, random_sentences_to_add: 4),
    	user_id: rand(1..5)
    )
  
end

for i in 1..30 do
	Comment.create(
		comment: Faker::Lorem.sentence(word_count: 10, supplemental: false, random_words_to_add: 10),
    	vlog_id: rand(1..6),
    	user_id: rand(1..5),
		)
end

for i in 1..30 do
	Like.create(
    	vlog_id: rand(1..10),
    	user_id: rand(1..5),
		)
end
