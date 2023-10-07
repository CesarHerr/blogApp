require 'swagger_helper'

RSpec.describe 'Posts API', type: :request do
  path '/api/v1/users/{user_id}/posts' do
    get 'List all posts' do
      tags 'Posts by user'
      produces 'application/json', 'application/xml'
      parameter name: :user_id, in: :path, type: :integer

      request_body_example value: { id: '23', author_id: '25', title: 'title', text: 'some text', comments_counter: '3',
                                    likes_counter: '0', created_at: '2023-10-06T05:20:17.227Z',
                                    updated_at: '2023-10-06T05:20:17.227Z' },
                           name: 'basic', summary: 'request example description'

      response '200', 'Posts found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   author_id: { type: :integer },
                   title: { type: :string },
                   text: { type: :string },
                   comments_counter: { type: :integer },
                   likes_counter: { type: :integer },
                   created_at: { type: :string },
                   updated_at: { type: :string }
                 },
                 required: %w[id author_id title text]
               }

        let(:user_id) { User.create(name: 'Swagger', email: 'test1@email.com', password: '123456').id }
        run_test!
      end

      response '404', 'User not found' do
        let(:user_id) { 'invalid' }
        run_test!
      end
    end
  end
end
