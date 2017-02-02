get "/sessions/new" do
  erb :"sessions/new"
end

post "/sessions" do
  user = User.find_by(username: params[:username])
  if user && user.authenticate?(params[:password])
    session[:user] = user.id
    redirect "/users/#{user.id}"
  else
    @error = "Incorrect login"
    erb :"sessions/new"
  end
end

delete "/sessions" do
  session[:user] = nil
  redirect "/"
end
