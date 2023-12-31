class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :comments, foreign_key: :user_id
  has_many :likes, foreign_key: :user_id
  has_many :posts, foreign_key: :author_id

  validates :name, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }

  def recent_post_by_author(author_id)
    posts.where(author_id:).order(created_at: :desc).limit(3)
  end

  def set_default_user_role
    self.role ||= 'admin'
  end
end
