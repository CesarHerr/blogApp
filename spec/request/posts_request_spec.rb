require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'Get /index' do
    it 'returns http success' do
      get '/users/:user_id/posts'
      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(200)
    end

    it 'returns the expected content' do
      get '/users/:user_id/posts'
      expect(response.body).to include('This is Post index')
    end
  end

  describe 'Get /show' do
    it 'returns http success' do
      get '/users/:user_id/posts/:post_id'
      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(200)
    end

    it 'returns the expected content' do
      get '/users/:user_id/posts/:post_id'
      expect(response.body).to include('This is Post show')
    end
  end
end
