class UsersController < ApplicationController
  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @post = Post.where(author_id: params[:id]).order(created_at: :desc)
  end
end
