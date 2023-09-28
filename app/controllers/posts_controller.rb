class PostsController < ApplicationController
  def index
    @users = User.all
    @posts = Post.all
    @comments = Comment.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.all
  end
end
