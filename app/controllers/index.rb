get '/' do
  # Look in app/views/index.erb
  redirect '/questions'
end

post 'questions/:question_id/recipes/:recipe_id/votes' do
  recipe = Recipe.find(params[:recipe_id])
  answer.votes.create(up_vote: params[:up_vote])
  redirect "/questions"

end
