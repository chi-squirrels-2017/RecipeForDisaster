get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/answers/:id/vote' do
  post = Answer.find(params[:id])
  post.votes.create(up_vote: 1)
  redirect "/posts"

end
