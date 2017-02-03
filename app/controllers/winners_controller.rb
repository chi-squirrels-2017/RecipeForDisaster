
put '/questions/:question_id/recipes/:recipe_id/winners/new' do
  question = Question.find_by(id: params[:question_id])
  recipe = Recipe.find_by(id: params[:recipe_id])
  recipe.voted_as_best
  redirect "/questions/#{params[:question_id]}"
end
