require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:each) do
    @user = User.create(name: 'César', photo: 'www.google.com', bio: 'Super Bio')
    @post = Post.create(author: @user, title: 'Super Post', text: 'Super Text')
    @like = Like.create(author: @user, post: @post)
  end

  describe 'instantiation' do
    it 'should instantiate a like object' do
      expect(@like).to be_an_instance_of(Like)
    end
  end

  describe 'callbacks and method' do
    it 'should update the likes_counter of the post' do
      expect(@post.likes_counter).to eq(1)
    end

    it 'should update the likes_counter of the post after destroy' do
      @like.destroy

      expect(@post.reload.likes_counter).to eq(0)
    end
  end
end
