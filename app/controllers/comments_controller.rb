get '/questions/:question_id/comments/new' do
  if logged_in?
    @question = Question.find_by_id(params[:question_id])
    if request.xhr?
      erb :'comments/new_question', layout: false
    else
      erb :'comments/new_question'
    end
  else
    erb :'sessions/new'
  end
end

post '/questions/:question_id/comments' do
  if logged_in?
    @question = Question.find_by_id(params[:question_id])
    @comment = @question.comments.create(params[:comment])
    if @comment.save
      if request.xhr?
        content_type :json
        {comment: @comment.body, user: @comment.user.username}.to_json
      else
        redirect "/questions/#{@question.id}"
      end
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
    if request.xhr?
       erb :'comments/new_recipe', layout: false
    else
      erb :'comments/new_recipe'
    end
  else
    erb :'sessions/new'
  end
end

post '/questions/:question_id/recipes/:recipe_id/comments' do
  if logged_in?
    @question = Question.find_by_id(params[:question_id])
    @recipe = Recipe.find_by_id(params[:recipe_id])
    @comment = @recipe.comments.create(params[:comment])
    if @comment.save
      if request.xhr?
        content_type :json
        {comment: @comment.body, user: @comment.user.username}.to_json
      else
        redirect "/questions/#{@question.id}"
      end
    else
      @errors = @comment.errors.full_messages
      erb :'comments/new_recipe'
    end
  else
    erb :'/sessions/new'
  end
end
