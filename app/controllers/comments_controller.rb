class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params.require(:comment).permit(:text))
    @comment.user = current_user
    if @comment.save
      redirect_to user_post_path(current_user, @post)
    else
      render :new
    end
  end
end
