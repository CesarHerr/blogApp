class Like < ApplicationRecord
  belongs_to :author
  belongs_to :posts

  after_create :likes_counter
  after_destroy :likes_counter

  def likes_counter
    post.update_column(:likes_counter, post.likes.count)
  end
end
