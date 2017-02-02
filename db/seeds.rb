require 'faker'

10.times do
  User.create(
               username: Faker::Internet.user_name,
                email: Faker::Internet.email, hashed_password: ("a".."z").to_a.sample(13).join)
end

50.times do
  Question.create(title: Faker::Pokemon.name, body: Faker::Company.catch_phrase, user_id: rand(1..10))
end

50.times do
  Recipe.create(question_id: rand(1..50), user_id: rand(1..10), body: Faker::Lorem.paragraph)
end

250.times do
  Comment.create(
               body: Faker::ChuckNorris.fact,
                user_id: rand(1..50),
                commentable_id: rand(1..50),
                commentable_type: ["Question", "Recipe"].sample
              )
end

250.times do
  Vote.create(
           voteable_id: rand(1..50),
            voteable_type: ["Question", "Recipe"].sample,
            up_vote: [false, true].sample,
            user_id: rand(1..10)
          )
end

