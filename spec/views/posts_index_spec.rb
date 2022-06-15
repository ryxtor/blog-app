require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  describe 'Index' do
    before(:each) do
      @user1 = User.create(id: 1000, name: 'test', email: 'a@a', password: '123456',
                           confirmed_at: Time.now, posts_counter: 0)
      @user2 = User.create(id: 1001, name: 'test2', email: 'b@b', password: '123456',
                           confirmed_at: Time.now, posts_counter: 0)
      @post1 = Post.create(id: 1000, user_id: 1000, title: 'post1', text: 'text')
      @post2 = Post.create(id: 1001, user_id: 1000, title: 'post2', text: 'text')
      @post3 = Post.create(id: 1002, user_id: 1000, title: 'post3', text: 'text')
      @post4 = Post.create(id: 1003, user_id: 1000, title: 'post4', text: 'my post')

      @comment1 = @post4.comments.create(user_id: 1000, text: 'comment1')
      @comment2 = @post4.comments.create(user_id: 1001, text: 'comment2')
      @comment3 = @post4.comments.create(user_id: 1000, text: 'comment3')
      @comment4 = @post4.comments.create(user_id: 1001, text: 'comment4')

      @like = @post4.likes.create(user_id: 1000)
      @like = @post4.likes.create(user_id: 1000)

      visit new_user_session_path
      fill_in 'Email', with: 'a@a'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      click_link 'test'
      click_link 'See all posts'
    end

    it 'I can see the user\'s profile picture.' do
      expect(page).to have_selector('img')
    end

    it 'I can see the user\'s username.' do
      expect(page).to have_content('test')
    end

    it 'I can see the number of posts the user has written.' do
      expect(page).to have_content('Posts: 4')
    end

    it 'I can see a post\'s title.' do
      expect(page).to have_content('post3')
    end

    it 'I can see some of the post\'s body.' do
      expect(page).to have_content('my post')
    end

    it 'I can see how many comments a post has.' do
      expect(page).to have_content('Comments: 4')
    end

    it 'I can see how many likes a post has.' do
      expect(page).to have_content('Likes: 2')
    end

    it 'When I click on a post, it redirects me to that post\'s show page.' do
      click_on 'post1'
      expect(page.current_path).to eq('/users/1000/posts/1000')
    end
  end
end
