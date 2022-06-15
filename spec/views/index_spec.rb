require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'index' do
    before(:each) do
      User.create(name: 'Test', email: 'a@a', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', password: '123456', posts_counter: 3,
                  confirmed_at: Time.now)
      User.create(name: 'Test2', email: 'b@b', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', password: '123456', posts_counter: 5,
                  confirmed_at: Time.now)

      visit new_user_session_path

      fill_in 'Email', with: 'a@a'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
    end

    it 'should show user list' do
      expect(page).to have_content('Test')
      expect(page).to have_content('Test2')
    end

    it 'should show a user picture' do
      expect(page).to have_selector('img', count: 2)
    end

    it "should show the user's posts" do
      expect(page).to have_content('Posts: 3')
      expect(page).to have_content('Posts: 5')
    end

    it 'should redirect to user page when user name is clicked' do
      click_link 'Test'
      expect(page).to have_content('See all posts')
    end
  end
end
