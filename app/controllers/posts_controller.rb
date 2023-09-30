class PostsController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.all
  end

  def new
    @user = current_user
    @new_post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = 'Post successfully added!'
      redirect_to user_path(current_user)
    else
      flash[:alert] = 'Post could not be added.'
      redirect_to new_user_post_path(current_user)
    end
  end

  def like
    @post = Post.find(params[:id])
    @like = Like.new(post: @post, author: current_user)

    if @like.save
      flash[:notice] = 'You have liked the post!.'
    else
      flash[:alert] = "Something is wrong!, you don't liked the post!."
    end

    redirect_to user_post_path(current_user.id, @post.id)
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
