class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.where.not(admin: true).paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id), notice: "ユーザー情報が更新されました"
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_url, notice: "対象のユーザを削除しました."
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to user_path(current_user)
    end
  end

  def admin_user
      redirect_to root_url unless current_user.admin?
  end

end
