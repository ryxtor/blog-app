require 'rails_helper'

RSpec.describe 'Posts Controller', type: :request do
  describe 'Index Action' do
    before(:each) do
      user = User.first
      get "/users/#{user.id}/posts"
    end

    it 'Should render posts' do
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
      post = user.posts.create(title: 'Post title', text: 'Post text')
      get "/users/#{user.id}/posts/#{post.id}"
    end

    it 'Should render user specific post' do
      expect(response).to render_template(:show)
    end

    it 'Response status is correct' do
      expect(response).to have_http_status(:ok)
    end

    it 'Response body includes correct text' do
      expect(response.body).to include('Comments:')
    end
  end
end
