class ApplicationController < ActionController::Base
  helper_method :current_user, :log_in
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by id:session[:user_id]
    else
      @current_user = nil
    end
  end

  def log_in user
    session[:user_id] = user.id
  end
end
