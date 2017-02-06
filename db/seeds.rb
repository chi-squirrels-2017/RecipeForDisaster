require 'faker'

5.times do
  User.create(
              username: Faker::Internet.user_name,
              email: Faker::Internet.email, password: ("a".."z").to_a.sample(13).join)
end

5.times do
  Question.create(title: Faker::Lorem.sentence(1, false, 2), body: Faker::Lorem.sentence(5, false, 5), user_id: rand(1..5))
end

5.times do
  Recipe.create(question_id: rand(1..5), user_id: rand(1..5), body: Faker::Lorem.paragraph(8, false, 4), best_answer: false)
end

20.times do
  Comment.create(
               body: Faker::Lorem.paragraph(2, false,2),
                user_id: rand(1..5),
                commentable_id: rand(1..5),
                commentable_type: ["Question", "Recipe"].sample
              )
end

25.times do
  Vote.create(
           voteable_id: rand(1..5),
            voteable_type: ["Question", "R
              ecipe"].sample,
            up_vote: [false, true].sample,
            user_id: rand(1..5)
          )
end

