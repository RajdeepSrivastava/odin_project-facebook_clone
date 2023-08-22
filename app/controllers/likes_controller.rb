class LikesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)
    if @like.save
      redirect_to posts_path, notice: 'Liked the post!'
    else
      redirect_to posts_path, alert: 'Could not like the post.'
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    redirect_to posts_path, notice: 'Unliked the post!'
  end
end




