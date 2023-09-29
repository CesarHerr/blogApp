class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :user_id
  belongs_to :post

  validates :text, presence: true

  after_create :comments_counter
  after_destroy :comments_counter

  def comments_counter
    post.update_column(:comments_counter, post.comments.count)
  end
end
