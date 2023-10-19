class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create addlike deletelike destroy]
  before_action :find_user_by_id, only: %i[index show]

  def index
    @posts = @user.posts.page(params[:page]).per(3).order('created_at ASC')
  end

  def show
    @post = Post.includes(comments: :author).find(params[:id])
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

  def destroy
    @post = Post.includes(comments: :author).find(params[:id])
    authorize! :destroy, @post
    if @post.destroy
      flash[:notice] = 'Post successfully deleted!'
    else
      flash[:alert] = 'Post could not be deleted.'
    end
    redirect_to user_path(current_user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def find_user_by_id
    @user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Error! User not found'
    redirect_to users_url
  end
end
