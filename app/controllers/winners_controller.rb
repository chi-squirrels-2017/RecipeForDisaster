
put '/questions/:question_id/recipes/:recipe_id/winners/new' do
  if request.xhr?
    recipe = Recipe.find_by(id: params[:recipe_id])
    recipe.voted_as_best
    "<img src='https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQZhNqd6H9ldLCUj6LBY3qMTh-LVM10tT_wgTyh_qVV7fEw0eJJ'>"
  else
    question = Question.find_by(id: params[:question_id])
    recipe = Recipe.find_by(id: params[:recipe_id])
    recipe.voted_as_best
    redirect "/questions/#{params[:question_id]}"
  end
end
