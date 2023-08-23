class PostsController < ApplicationController
    before_action :authenticate_user!
    
    def index
      friend_ids = current_user.friends.pluck(:id)
      friend_ids << current_user.id # Include the current user's posts as well
      @posts = Post.where(user_id: friend_ids).order(created_at: :desc)
      @post = Post.new
    end
    
    def new
      @post = Post.new
    end
  
    def create
      @post = current_user.posts.build(post_params)
      if @post.save
        redirect_to posts_path, notice: 'Post created!'
      else
        @posts = Post.all
        render :index
      end
    end
  
    private
  
    def post_params
      params.require(:post).permit(:content)
    end
  end
  