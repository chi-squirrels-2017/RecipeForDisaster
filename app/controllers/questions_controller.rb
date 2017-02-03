require 'pry'

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


