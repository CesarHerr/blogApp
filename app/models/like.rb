class Like < ApplicationRecord
  belongs_to :author
  belongs_to :posts

  def likes_counter
    post.update_column(:likes_counter, post.likes.count)
  end

end
