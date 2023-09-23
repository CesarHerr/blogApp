require 'rails_helper'

RSpec.describe Post, type: :model do

  before(:each) do
    @user = User.create(name: "César", photo: "www.google.com", bio: "Super Bio")
    @post = Post.create(author: @user, title: "Super Post", text: "Super Text")
  end

  describe "instantiation" do
    it "should instantiate a post object" do
      expect(@post).to be_an_instance_of(Post)
    end
  end

  describe "validations" do
    it "is valid with a title and a valid comments_counter and likes_counter" do
      expect(@post).to be_valid
    end

    it "is invalid without a title" do
      post = Post.create(author: @user, title: "", text: "Test Text")
      expect(post).to_not be_valid
    end

    it "is invalid with a comments_counter less than 0" do
      post = Post.new(author: @user, title: "Test Post", text: "Test Text", comments_counter: -1)
      expect(post).to_not be_valid
    end

    it "is invalid with a likes_counter less than 0" do
      post = Post.new(author: @user, title: "Test Post", text: "Test Text", likes_counter: -1)
      expect(post).to_not be_valid
    end

    it "is invalid with a title longer than 250 characters" do
      post = Post.new(author: @user, title: "Hi" * 251, text: "Hello")
      expect(post).to_not be_valid
    end
  end

  describe "callbacks" do
    it "should update the author's posts_counter after create" do
      expect(@user.reload.posts_counter).to eq(1)
    end

    it "should update the author's posts_counter after destroy" do
      @post.destroy

      expect(@user.reload.posts_counter).to eq(0)
    end
  end

  describe "methods" do
    it "should return recent 5 comments" do

      comment1 = Comment.create(post: @post, author:@user, text: "Comment 1")
      comment2 = Comment.create(post: @post, author:@user, text: "Comment 2")
      comment3 = Comment.create(post: @post, author:@user, text: "Comment 3")
      comment4 = Comment.create(post: @post, author:@user, text: "Comment 4")
      comment5 = Comment.create(post: @post, author:@user, text: "Comment 5")
      comment6 = Comment.create(post: @post, author:@user, text: "Comment 6")

      recent_comments = @post.recent_comments.to_a

      expect(recent_comments).to eq([comment6, comment5, comment4, comment3, comment2])
    end
  end
end
