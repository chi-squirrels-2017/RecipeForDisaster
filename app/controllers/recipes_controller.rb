
get '/questions/:question_id/recipes/new' do
  if logged_in?
    @question = Question.find_by(id: params[:question_id])
    @user_id = session[:user]
    erb :'recipes/new'
  else
    erb :'_404'
  end
end

post '/questions/:question_id/recipes' do
  if logged_in?
    # TODO: clean this noise - use recipe hash inside params?
    recipe = Recipe.new(question_id: params[:question_id], user_id: params[:user_id], body: params[:recipe_body], best_answer: false)
    if recipe.save
      redirect "/questions/#{params[:question_id]}"
    else
      @errors = recipe.errors.full_messages
      erb :'recipes/new'
    end
  else
    erb :'_404'
  end
end

get '/questions/:question_id/recipes/:recipe_id' do
  @recipe = Recipe.find_by(id: params[:recipe_id])
  @question = Question.find_by(id: params[:question_id])
  @comments = Comment.where(commentable_id: params[:recipe_id], commentable_type: 'Recipe')
  if @recipe && @question
    redirect "/questions/#{@question.id}"
  else
    erb :'_404'
  end
end

get '/questions/:question_id/recipes/:recipe_id/edit' do
  # if this user is the recipe's author, allow the following
  @recipe = Recipe.find_by(id: params[:recipe_id])
  @question = Question.find_by(id: params[:question_id])
  if @recipe && @question && logged_in? && @recipe.user.id == current_user.id
    erb :'recipes/edit'
  else
    erb :'_404'
  end
  # else
  #   erb :'_404'
  # end
end

put '/questions/:question_id/recipes/:recipe_id' do
  @question = Question.find_by(id: params[:question_id])
  @recipe = Recipe.find_by(id: params[:recipe_id])
  @recipe.update_attribute(:body, params[:recipe_body])#replace due to bypass validations
  if @recipe && @question && logged_in? && @recipe.user.id == current_user.id
    if @recipe.save
      redirect "/questions/#{params[:question_id]}/recipes/#{params[:recipe_id]}"
    else
      @errors = @recipe.errors.full_messages
      erb :'recipes/edit'
    end
  else
    erb :'_404'
  end
end

delete '/questions/:question_id/recipes/:recipe_id' do
  if @recipe && @question && logged_in? && @recipe.user.id == current_user.id
    recipe = Recipe.find_by(id: params[:recipe_id])
    recipe.destroy
    redirect '/' #redirect to previous show page
  else
    erb :'_404'
  end
  end
