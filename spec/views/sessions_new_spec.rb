require 'rails_helper'

RSpec.describe 'Session', type: :system do
  describe 'new' do
    before(:each) do
      User.create(name: 'test', email: 'a@a', password: '123456', confirmed_at: Time.now)
      visit new_user_session_path
    end

    it 'should show login form' do
      expect(page).to have_content('Email')
      expect(page).to have_content('Password')
      expect(page).to have_content('Log in')
    end

    it 'should show error message when login failed' do
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'should show error message when login failed with invalid data' do
      fill_in 'Email', with: 'a@asd'
      fill_in 'Password', with: '12345'
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'should redirect to root page when login success' do
      fill_in 'Email', with: 'a@a'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      expect(page).to have_content('Posts')
    end
  end
end
