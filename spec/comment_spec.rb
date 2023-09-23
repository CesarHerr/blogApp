require 'rails_helper'

RSpec.describe Comment, type: :model do

    before(:each) do
      @user = User.create(name: "Test User", photo: "www.google.com", bio: "test bio")
      @post = Post.create(author: @user, title: "Test Post", text: "Test Text")
      @comment = Comment.create(post: @post, author:@user, text: "Comment 1")
    end

    describe "instantiation" do
      it "should instantiate a comment object" do
        expect(@comment).to be_an_instance_of(Comment)
      end
    end

    describe "callbacks and method" do
      it "should update the post's comments_counter after create" do

        expect(@post.reload.comments_counter).to eq(1)
      end

      it "should update the post's comments_counter after destroy" do
        @comment.destroy

        expect(@post.reload.comments_counter).to eq(0)
      end
    end
end
