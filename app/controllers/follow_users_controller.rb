class FollowUsersController < ApplicationController
  def create
    @user = User.find_by id: params[:followed_id]
    byebug
    status = current_user.follow(@user) ? true : false
    respond_to do |format|
      format.json do
        render json: {status: status}
      end
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    status = current_user.unfollow(@user) ? true : false
    respond_to do |format|
      format.json do
        render json: {status: status}
      end
    end
  end
end
