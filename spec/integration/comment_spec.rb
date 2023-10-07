require 'swagger_helper'

RSpec.describe 'Comments API', type: :request do
  path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
    parameter name: :user_id, in: :path, type: :integer, required: true
    parameter name: :post_id, in: :path, type: :integer, required: true

    get 'List all comments by post' do
      tags 'Comments by posts'
      produces 'application/json', 'application/xml'

      response '200', 'Comments found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   user_id: { type: :integer },
                   post_id: { type: :integer },
                   text: { type: :string },
                   created_at: { type: :string, format: 'date-time' },
                   updated_at: { type: :string, format: 'date-time' }
                 },
                 required: %w[id user_id post_id text]
               }

        let(:user) { User.create(name: 'Swagger', email: 'test4@example.com', password: '123456') }
        let(:post) { Post.create(author_id: user.id, title: 'Hello', text: 'This is my first post') }

        let(:user_id) { user.id }
        let(:post_id) { post.id }

        run_test!
      end
    end

    post 'Create a comment in a post' do
      tags 'Comments'
      consumes 'application/json', 'application/xml'
      parameter name: :text, in: :body, type: :string, description: 'Comment text', required: true

      request_body_example value: {
        user_id: 1,
        post_id: 123,
        text: 'This is an example comment.'
      }

      response '201', 'Comment created' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 user_id: { type: :integer },
                 post_id: { type: :integer },
                 text: { type: :string },
                 created_at: { type: :string, format: 'date-time' },
                 updated_at: { type: :string, format: 'date-time' }
               }

        let(:user_id) { User.create(name: 'Swagger', email: 'test@example.com', password: '123456').id }
        let(:post_id) { Post.create(author_id: user_id, title: 'Hello', text: 'This is my first post').id }

        let(:text) { 'This is a comment text' }

        run_test!
      end

      response '422', 'unprocessable_entity' do
        let(:user_id) { User.create(name: 'Swagger', email: 'test@example.com', password: '123456').id }
        let(:post_id) { Post.create(author_id: user_id, title: 'Hello', text: 'This is my first post').id }
        let(:text) { '' }

        run_test!
      end
    end
    end
end
