
get '/questions/:question_id/recipes/new' do
  @question = Question.find_by(id: params[:question_id])
  @user_id = session[:user]
  erb :'recipes/new'
end

post '/questions/:question_id/recipes' do
  # TODO: clean this noise - use recipe hash inside params?
  recipe = Recipe.new(question_id: params[:question_id], user_id: params[:user_id], body: params[:recipe_body], best_answer: false)
  if recipe.save
    redirect "/questions/#{params[:question_id]}"
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
  if @recipe && @question
    erb :'recipes/show'
  else
    erb :'_404'
  end
end

get '/questions/:question_id/recipes/:recipe_id/edit' do
  @recipe = Recipe.find_by(id: params[:recipe_id])
  @question = Question.find_by(id: params[:question_id])
  if @recipe && @question
    erb :'recipes/edit'
  else
    erb :'_404'
  end
end

put '/questions/:question_id/recipes/:recipe_id' do
  @question = Question.find_by(id: params[:question_id])
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

post '/questions/:question_id/recipes/:recipe_id/votes' do
  @question = Question.find_by_id(params[:question_id])
  @recipe = Recipe.find_by_id(params[:recipe_id])
  if current_user && current_user.votes.where("voteable_id = #{@recipe.id}").count == 0
    @recipe.votes.create(up_vote: params[:up_vote], user_id: current_user.id)
    if request.xhr?
      content_type :json
      {upvotes: @answer.up_points, downvotes: @answer.down_points}.to_json
    else
      redirect "/questions/#{params[:question_id]}"
    end
  end
    redirect "/questions/#{params[:question_id]}"

end
