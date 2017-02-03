get '/questions/:question_id/comments/new' do
  if logged_in?
    @question = Question.find_by_id(params[:question_id])
    erb :'comments/new_question'
  else
    erb :'sessions/new'
  end
end

post '/questions/:question_id/comments' do
  if logged_in?
    @question = Question.find_by_id(params[:question_id])
    @comment = @question.comments.create(params[:comment])
    if @comment.save
      redirect "/questions/#{@question.id}"
    else
      @errors = @comment.errors.full_messages
      erb :'comments/new_question'
    end
  else
    erb :'sessions/new'
  end
end

get '/questions/:question_id/recipes/:recipe_id/comments/new' do
  if logged_in?
    @question = Question.find_by_id(params[:question_id])
    @recipe = Recipe.find_by_id(params[:recipe_id])
    erb :'comments/new_recipe'
  else
    erb :'sessions/new'
  end
end

post '/questions/:question_id/recipes/:recipe_id/comments' do
  if logged_in?
    @question = Question.find_by_id(params[:question_id])
    @recipe = Recipe.find_by_id(params[:recipe_id])
    @comment = @recipe.comments.create(params[:comment])
    p '8'* 50
    p @comment
    if @comment.save
      redirect "/questions/#{@question.id}"
    else
      @errors = @comment.errors.full_messages
      erb :'comments/new_recipe'
    end
  else
    erb :'/sessions/new'
  end
end
