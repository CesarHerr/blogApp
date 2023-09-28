require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'Get /index' do
    it 'returns http success' do
      get '/users'
      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get '/users'
      expect(response).to render_template('index')
    end

    it 'returns the expected content' do
      get '/users'
      expect(response.body).to include('This is User index')
    end
  end

  describe 'Get /show' do
    it 'returns http success' do
      get '/users/:user_id'
      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get '/users/:user.id'
      expect(response).to render_template('show')
    end

    it 'returns the expected content' do
      get '/users/:user_id'
      expect(response.body).to include('This is User show')
    end
  end
end