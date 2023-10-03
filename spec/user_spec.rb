require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create(name: 'Ruth', photo: 'www.google.com', bio: 'test bio')
  end

  describe 'instantiation' do
    it 'should instantiate a user object' do
      expect(@user).to be_an_instance_of(User)
    end

    describe 'validations' do
      it 'is valid with a name and a valid posts_counter' do
        expect(@user).to be_valid
      end

      it 'is invalid without a name' do
        user = User.create(name: '', photo: 'www.google.com', bio: 'test bio')
        expect(user).to_not be_valid
      end

      it 'is invalid with a posts_counter less than 0' do
        user = User.new(name: 'Ruth', photo: 'https://www.google.com', bio: "I'm a developer", posts_counter: -1)
        expect(user).to_not be_valid
      end
    end

    describe 'methods' do
      it 'returns recent 3 posts by author' do
        Post.create(author: @user, title: 'Post 1', text: 'Content of Post 1')
        post2 = Post.create(author: @user, title: 'Post 2', text: 'Content of Post 2')
        post3 = Post.create(author: @user, title: 'Post 3', text: 'Content of Post 3')
        post4 = Post.create(author: @user, title: 'Post 4', text: 'Content of Post 4')

        recent_posts = @user.recent_post_by_author(@user.id)

        expect(recent_posts.to_a).to eq([post4, post3, post2])
      end
    end
  end
end
