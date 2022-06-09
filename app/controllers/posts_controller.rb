class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:success] = 'Post created!'
      redirect_to user_post_path(@user, @post)
    else
      flash[:error] = 'Post not created!'
      redirect_to "/users/#{@user.id}/posts/new"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
