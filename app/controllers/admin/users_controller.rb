class Admin::UsersController < ApplicationController
  before_action :load_user, except: :index
  before_action :current_admin
  def index
    @users = User.all
  end

  def block
    status = @user.toggle(:non_block) if @user
    @user.save
    status = true if status
    block = @user.non_block? ? t("Block") : t("Unblock")
    respond_to do |format|
      format.json do
        render json: {status: status, block: block}
      end
    end
  end

  def destroy
    status = @user.destroy if @user
    status = true if status
    respond_to do |format|
      format.json do
        render json: {status: status}
      end
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
  end
end
