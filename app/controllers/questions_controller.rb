get '/questions' do
  @questions = Question.all

  erb :'questions/index'
end

get '/questions/new' do
  if logged_in?
    erb :'questions/new'
  else
    erb :'_404'
  end
end

post '/questions' do
  if logged_in?
    @question = Question.create(params[:question])
    redirect '/questions'
  else
    erb :'_404'
  end
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
  if logged_in? && current_user && current_user.votes.where("voteable_id = #{@question.id}").count == 0
    @question.votes.create(up_vote: params[:up_vote], user_id: current_user.id)
    # p request
    if request.xhr?
      content_type :json
      {upvotes: @question.up_points, downvotes: @question.down_points}.to_json
    else
      redirect "/questions"
    end
  end
end


