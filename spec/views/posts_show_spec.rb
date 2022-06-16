require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  describe 'Show' do
    before(:each) do
      @user1 = User.create(id: 1000, name: 'test', email: 'a@a', password: '123456',
                           confirmed_at: Time.now, posts_counter: 0)
      @user2 = User.create(id: 1001, name: 'test2', email: 'b@b', password: '123456',
                           confirmed_at: Time.now, posts_counter: 0)
      @post1 = Post.create(id: 1000, user_id: 1000, title: 'post1', text: 'text')
      @post2 = Post.create(id: 1001, user_id: 1000, title: 'post2', text: 'text')
      @post3 = Post.create(id: 1002, user_id: 1000, title: 'post3', text: 'text')
      @post4 = Post.create(id: 1003, user_id: 1000, title: 'post4', text: 'this is a big post')

      @comment1 = @post4.comments.create(user_id: 1000, text: 'comment1')
      @comment2 = @post4.comments.create(user_id: 1001, text: 'comment2')

      @like = @post4.likes.create(user_id: 1000)

      visit new_user_session_path
      fill_in 'Email', with: 'a@a'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      click_link 'test'
      click_link 'post4'
    end

    it 'Should show the post title' do
      expect(page).to have_content('post4')
    end

    it 'Should show the author name' do
      expect(page).to have_content('test')
    end

    it 'Should show comments_counter' do
      expect(page).to have_content('Comments: 2')
    end

    it 'Should show likes_counter' do
      expect(page).to have_content('Likes: 1')
    end

    it 'Should show the post text' do
      expect(page).to have_content('this is a big post')
    end

    it 'Should show the username of each comment' do
      expect(page).to have_content('test:')
      expect(page).to have_content('test2:')
    end

    it 'Should show the comment text' do
      expect(page).to have_content('comment1')
      expect(page).to have_content('comment2')
    end
  end
end
