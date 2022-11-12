class HomesController < ApplicationController
  def top
    @post_images = PostImage.page(params[:page]).reverse_order
  end
end
