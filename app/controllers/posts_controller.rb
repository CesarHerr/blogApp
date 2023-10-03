class PostsController < ApplicationController
  before_action :find_current_user, only: %i[new create]

  def index
    @user =User.find(params[:user_id])
    @posts = @user.posts.page(params[:page]).per(3)
  end

  def show
    @post = Post.includes(comments: :author).find(params[:id])
  end

  def new
    @new_post = Post.new
  end

  def create
    @post = @user.posts.new(post_params)
    if @post.save
      flash[:notice] = 'Post successfully added!'
      redirect_to user_path(current_user)
    else
      flash[:alert] = 'Post could not be added.'
      redirect_to new_user_post_path(current_user)
    end
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end

  private

  def find_current_user
    @user = current_user
  end
end
