class Comment < ActiveRecord::Base
  belongs_to :user, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  after_save :update_comment_counter

  def update_comment_counter
    post.increment!(:comments_counter)
  end
end
