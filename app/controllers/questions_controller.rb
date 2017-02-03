get '/questions' do
  @questions = Question.all

  erb :'questions/index'
end

get '/questions/new' do
  if session[:user]
    erb :'questions/new'
  else
    erb :'_404'
  end
end

post '/questions' do
  @question = Question.create(params[:question])

  redirect '/questions'
end


get '/questions/:question_id' do
  @question = Question.find_by_id(params[:question_id])

  erb :'questions/show'
end

put '/questions/:question_id/edit' do

end

get '/questions/:question_id/edit' do

end

post '/questions/:question_id/votes' do
  @question = Question.find_by_id(params[:question_id])
  @question.votes.create(up_vote: params[:up_vote])
  # p request
  if request.xhr?
    content_type :json
    {upvotes: @question.votes.where(["up_vote = ?", true]).count, downvotes: @question.votes.where(["up_vote = ?", false]).count}.to_json
  else
    redirect "/questions"
  end
end


