require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let(:post) { Post.create(author: user, title: 'Hello', text: 'This is my first post') }

  describe 'GET /index' do
    it 'returns http success' do
      get "/users/#{user.id}/posts"
      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get "/users/#{user.id}/posts"
      expect(response).to render_template('index')
    end

    it 'returns the expected content' do
      get "/users/#{user.id}/posts"
      expect(response.body).to include('List of Posts')
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to render_template('show')
    end

    it 'returns the expected content' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.body).to include('Comments:')
    end
  end
end
