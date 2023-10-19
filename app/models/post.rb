class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments, foreign_key: :post_id, dependent: :destroy
  has_many :likes, foreign_key: :post_id, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :text, presence: true
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0 }

  after_create :user_posts_count
  after_destroy :user_posts_count

  def user_posts_count
    author.update_column(:posts_counter, author.posts.count)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
