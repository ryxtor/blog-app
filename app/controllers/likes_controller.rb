class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])

    return if @post.liked?(current_user)

    @like = Like.new(user_id: current_user.id, post_id: @post.id)

    if @like.save
      flash[:success] = 'Liked!'
    else
      flash[:error] = 'ERROR! Not liked!'
    end
    redirect_to user_post_path(current_user, @post)
  end
end
