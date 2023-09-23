class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :user_id
  belongs_to :post

  after_create :likes_counter
  after_destroy :likes_counter

  def likes_counter
    post.update_column(:likes_counter, post.likes.count)
  end
end
