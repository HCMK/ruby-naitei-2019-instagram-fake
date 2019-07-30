class UsersController < ApplicationController
  before_action :load_user, except: %i(index create new)

  def index; end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t "user_create_check_mail"
      redirect_to root_url
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:info] = t "user_update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:info] = t "user_destroy_success"
    redirect_to users_url
  end

  def following
    @title = t "following"
    @user  = User.find_by id: params[:id]
    @users = @user.following.page(params[:page])
    render "show_follow"
  end

   def followers
    @title = t "followers"
    @user  = User.find_by id: params[:id]
    @users = @user.followers.page(params[:page])
    render "show_follow"
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:waring] = t "user_not_exist"
    redirect_to root_url
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation, :avatar)
  end
end
