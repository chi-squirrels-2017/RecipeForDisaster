
get '/questions/:question_id/recipes/new' do
  @question = Question.find_by(id: params[:question_id])
  @user_id = session[:user]
  erb :'recipes/new'
end

post '/questions/:question_id/recipes' do
  # TODO: clean this noise - use recipe hash inside params?
  recipe = Recipe.new(question_id: params[:question_id], user_id: params[:user_id], body: params[:recipe_body], best_answer: false)
  if recipe.save
    redirect "/questions/#{params[:question_id]}/recipes/#{params[:recipe_id]}"
  else
    @errors = recipe.errors.full_messages
    erb :'recipes/new'
  end
  # redirect or show previous with errors
end

get '/questions/:question_id/recipes/:recipe_id' do
  @recipe = Recipe.find_by(id: params[:recipe_id])
  @question = Question.find_by(id: params[:question_id])

  @comments = Comment.where(commentable_id: params[:recipe_id], commentable_type: 'Recipe')
  erb :'recipes/show'
end

get '/questions/:question_id/recipes/:recipe_id/edit' do
  @recipe = Recipe.find_by(id: params[:recipe_id])
  @question = Question.find_by(id: params[:question_id])
  erb :'recipes/edit'
end

put '/questions/:question_id/recipes/:recipe_id' do
  @recipe = Recipe.find_by(id: params[:recipe_id])
  @recipe.update_attribute(:body, params[:recipe_body])#replace due to bypass validations
  if @recipe.save
    redirect "/questions/#{params[:question_id]}/recipes/#{params[:recipe_id]}"
  else
    @errors = @recipe.errors.full_messages
    erb :'recipes/edit'
  end
end

delete '/questions/:question_id/recipes/:recipe_id' do
    recipe = Recipe.find_by(id: params[:recipe_id])
    recipe.destroy
    redirect '/' #redirect to previous show page
  end
