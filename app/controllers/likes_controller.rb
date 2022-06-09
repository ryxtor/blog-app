class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])

    return if @post.liked?(current_user)

    @like = Like.create(user_id: current_user.id, post_id: @post.id)

    redirect_to user_post_path(current_user, @post)
  end
end
