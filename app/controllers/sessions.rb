get "/sessions/new" do
  erb :"sessions/new"
end

post "/sessions" do
  if request.xhr?
    user = User.find_by(username: params[:username])
    if user && user.authenticate?(params[:password])
      session[:user] = user.id
      @questions = Question.all
      erb :'/questions/index', layout: false, locals: {questions: @questions}
    else
      status 422
      "Incorrect Validation"
    end
  else
    user = User.find_by(username: params[:username])
    if user && user.authenticate?(params[:password])
      session[:user] = user.id
      redirect "/"
    else
      @error = "Incorrect login"
      erb :"sessions/new"
    end
  end
end

delete "/sessions" do
  session[:user] = nil
  redirect "/"
end
