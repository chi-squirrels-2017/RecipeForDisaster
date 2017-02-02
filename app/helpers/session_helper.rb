helpers do
  def current_user
     @_current ||= User.find_by(id: session[:user])
  end
end
