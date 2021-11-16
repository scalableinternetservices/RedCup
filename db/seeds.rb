# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

for i in 1..1000 do 
	date = Faker::Date.between(from: '2010-09-23', to: '2021-09-25')
    user=User.new(
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password,
    created_at: date,
	updated_at: date
  )
  user.save!
end

for i in 1..10000 do
	date = Faker::Date.between(from: '2010-09-23', to: '2021-09-25')
	Vlog.create(
		title: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4),
		content: Faker::Lorem.paragraph(sentence_count: 6, supplemental: true, random_sentences_to_add: 4),
		created_at: date,
		updated_at: date,
    	user_id: rand(1..1000)
    )
  
end

for i in 1..30000 do
	date = Faker::Date.between(from: '2010-09-23', to: '2021-09-25')
	Comment.create(
		comment: Faker::Lorem.sentence(word_count: 20, supplemental: false, random_words_to_add: 10),
    	vlog_id: rand(1..10000),
    	user_id: rand(1..1000),
    	created_at: date,
		updated_at: date,
		)
end

for i in 1..40000 do
	date = Faker::Date.between(from: '2010-09-23', to: '2021-09-25')
	Like.create(
    	vlog_id: rand(1..10000),
    	user_id: rand(1..1000),
    	created_at: date,
		updated_at: date,
		)
end
