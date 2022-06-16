require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'Show' do
    before(:each) do
      @user1 = User.create(id: 1000, name: 'test', email: 'a@a', password: '123456',
                           confirmed_at: Time.now, posts_counter: 0)
      @user2 = User.create(id: 1001, name: 'test2', email: 'b@b', password: '123456',
                           confirmed_at: Time.now, posts_counter: 0)
      @post1 = Post.create(id: 1000, user_id: 1000, title: 'post1', text: 'text')
      @post2 = Post.create(id: 1001, user_id: 1000, title: 'post2', text: 'text')
      @post3 = Post.create(id: 1002, user_id: 1000, title: 'post3', text: 'text')
      @post4 = Post.create(id: 1003, user_id: 1000, title: 'post4', text: 'text')

      visit new_user_session_path
      fill_in 'Email', with: 'a@a'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      click_link 'test'
    end

    it 'Should show user\'s profile picture' do
      expect(page).to have_selector('img')
    end

    it 'Should show user\'s name' do
      expect(page).to have_content('test')
    end

    it 'Should show user\'s number of posts' do
      expect(page).to have_content('Posts: 4')
    end

    it 'Should show user\'s bio' do
      expect(page).to have_content('Bio:')
    end

    it 'Should show user\'s last 3 posts' do
      expect(page).to have_content('post4')
      expect(page).to have_content('post3')
      expect(page).to have_content('post2')
      expect(page).to_not have_content('post1')
    end

    it 'Should show a See all posts button' do
      expect(page).to have_link('See all posts')
    end

    it 'Should redirect to all posts page when click See all posts button' do
      click_link 'See all posts'
      expect(page.current_path).to eq('/users/1000/posts')
    end

    it 'Should redirect to a post page when click a post title' do
      click_link 'post4'
      expect(page.current_path).to eq('/users/1000/posts/1003')
    end
  end
end
