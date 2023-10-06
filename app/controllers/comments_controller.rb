class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  before_action :find_post_by_id, only: %i[new create destroy]

  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(post: @post, author: @user, text: comment_params[:text])
    if @comment.save
      flash[:notice] = 'Comment successfully added!'
      redirect_to user_post_path(@user, @post)
    else
      flash[:alert] = 'Comment could not be added.'
      redirect_to new_user_post_comment_path(@user, @post)
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    authorize! :destroy, comment
    if comment.destroy
      flash[:notice] = 'The Post was deleted successfully!'
    else
      flash[:error] = 'Error! The Post was not deleted'
    end
    redirect_to user_post_path(@post.author, @post)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def find_post_by_id
    @post = Post.find(params[:post_id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Error! Post not found'
    redirect_to user_posts_path
  end
end
