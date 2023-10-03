class UsersController < ApplicationController
  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.includes(posts: :author).find(params[:id])
  end
end
