helpers do
  def current_user
     @_current ||= User.find_by(id: session[:user])
  end

  def logged_in?
    return true if session[:user]
  end
end
