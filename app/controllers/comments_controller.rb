get '/questions/:question_id/comments/new' do
  @question = Question.find_by_id(params[:question_id])
  erb :'comments/new_question'
end

post '/questions/:question_id/comments' do
  @question = Question.find_by_id(params[:question_id])
  @comment = @question.comments.create(params[:comment])
  if @comment.save
    redirect "/questions/#{@question.id}"
  else
    @errors = @comment.errors.full_messages
    erb :'comments/new_question'
  end
end

get '/questions/:question_id/recipes/:recipe_id/comments/new' do
  @question = Question.find_by_id(params[:question_id])
  @recipe = Recipe.find_by_id(params[:recipe_id])
  erb :'comments/new_recipe'
end

post '/questions/:question_id/recipes/:recipe_id/comments' do
  @question = Question.find_by_id(params[:question_id])
  @recipe = @recipe = Recipe.find_by_id(params[:recipe_id])
  @comment = @recipe.comments.create(params[:comment])
  if @comment.save
    redirect "/questions/#{@question.id}"
  else
    @errors = @comment.errors.full_messages
    erb :'comments/new_arecipe'
  end
end
