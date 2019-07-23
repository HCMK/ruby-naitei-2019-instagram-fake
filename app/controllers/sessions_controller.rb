class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by_email params[:email]
    if user && user.authenticate(params[:password])
      if user.activated?
        log_in user
        redirect_to root_path, notice: "Logged in!"
      else
        flash[:warning] = t("not_activated") + t("check_email")
        redirect_to root_url
      end
    else
      flash.now[:alert] = t "invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out!"
  end
end
