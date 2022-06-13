require 'rails_helper'

RSpec.describe 'Users Controller', type: :request do
  describe 'Index Action' do
    before(:each) do
      get '/users/'
    end

    it 'Should render users list' do
      expect(response).to render_template(:index)
    end

    it 'Response status is correct' do
      expect(response).to have_http_status(:ok)
    end

    it 'Response body includes correct text' do
      expect(response.body).to include('Posts:')
    end
  end

  describe 'Show Action' do
    before(:each) do
      user = User.first
      get "/users/#{user.id}"
    end

    it 'Should render a specific user' do
      expect(response).to render_template(:show)
    end

    it 'Response status is correct' do
      expect(response).to have_http_status(:ok)
    end

    it 'Response body includes correct text' do
      expect(response.body).to include('Bio:')
    end
  end
end
