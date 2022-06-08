class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = current_user.posts.new(params.require(:post).permit(:title, :text))
    if @post.save
      redirect_to user_post_path(@user, @post)
    else
      render :new
    end
  end
end
