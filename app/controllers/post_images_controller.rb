class PostImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user_or_current_user, only: [:edit, :destroy]
  before_action :correct_user, only: [:edit, :update,]

  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    if @post_image.save
      redirect_to post_images_path, notice: "投稿が完了しました"
    else
      render :new
    end
  end

  def edit
    @post_image = PostImage.find(params[:id])
  end

  def update
    @post_image = PostImage.find(params[:id])
    @post_image.update(post_image_params)
    redirect_to post_images_path, notice: "投稿情報を更新しました"
  end

  def index
    @post_images = PostImage.page(params[:page]).reverse_order
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end

  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to post_images_path, notice: "投稿情報を削除しました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def post_image_params
    params.require(:post_image).permit(:shop_name, :image, :caption)
  end

  def correct_user
    post_image = PostImage.find(params[:id])
    if current_user.id != post_image.user.id
      redirect_to post_images_path
    end
  end

  def admin_user_or_current_user
    redirect_to root_url unless current_user.admin? || current_user
  end
end
