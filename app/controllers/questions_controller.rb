get '/questions' do
  @questions = Question.all

  erb :'questions/index'
end

get '/questions/new' do

end

post '/questions' do


end


get '/questions/:question_id' do


end


