require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Validations' do
    it 'Should increase the post likes counter' do
      user = User.create(name: 'Lucas Bonnefon')
      post = Post.create(title: 'Post title', user_id: user.id)
      expect(post.likes_counter).to eq(0)
      post.likes.create(user_id: user.id)
      expect(post.likes_counter).to eq(1)
    end
  end
end
