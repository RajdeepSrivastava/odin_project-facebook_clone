class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
  end
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params.merge(user: current_user))
    if @comment.save
      redirect_to posts_path, notice: 'Comment added!'
    else
      redirect_to posts_path, alert: 'Could not add the comment.'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to posts_path, notice: 'Comment deleted!'
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
