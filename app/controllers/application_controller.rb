class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

#find the current user for various purposes
  def current_user
    session.clear if User.all.count == 0 && session[:user_id]
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @current_user
  end
  helper_method :current_user

#take us to the login unless we are logged in
  def authorize
    redirect_to '/login' unless current_user
  end

#this method tells us the status of a vote in order to let us know which button to show on the candidates page
  def vote_status(user, candidate)
    v = Vote.where(user_id: user.id, candidate_id: candidate.id)[0]
    if v
      p v.status
    end
  end
  helper_method :vote_status

end
