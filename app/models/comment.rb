class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :user_id
  belongs_to :post

  def comments_counter
    post.update_column(:comments_counter, post.comments.count)
  end
end
