require 'rails_helper'

RSpec.describe 'Posts Controller', type: :request do
  describe 'Index Action' do
    before(:each) do
      get '/users/:user_id/posts'
    end

    it 'Should render posts' do
      expect(response).to render_template(:index)
    end

    it 'Response status is correct' do
      expect(response).to have_http_status(:ok)
    end

    it 'Response body includes correct text' do
      expect(response.body).to include('Here is a list of all the posts')
    end
  end

  describe 'Show Action' do
    before(:each) do
      get '/users/:user_id/posts/:id'
    end

    it 'Should render user specific post' do
      expect(response).to render_template(:show)
    end

    it 'Response status is correct' do
      expect(response).to have_http_status(:ok)
    end

    it 'Response body includes correct text' do
      expect(response.body).to include('Here is a post of a single user:')
    end
  end
end
