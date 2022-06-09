require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Validations' do
    it 'Should increase the post comments counter' do
      user = User.create(name: 'Lucas Bonnefon')
      post = Post.create(title: 'Post title', user_id: user.id)
      expect(post.comments_counter).to eq(0)
      post.comments.create(text: 'Comment content', user_id: user.id)
      expect(post.comments_counter).to eq(1)
    end
  end
end
