class Post < ActiveRecord::Base
  belongs_to :user, class_name: 'User'
  has_many :comments, class_name: 'Comment'
  has_many :likes, class_name: 'Like'

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_post_counter

  def update_post_counter
    user.increment!(:posts_counter)
  end

  def most_recent_comments
    comments.limit(5).order(created_at: :desc)
  end

  def short_text
    text.truncate(75)
  end

  def liked?(user)
    likes.where(user_id: user.id).any?
  end
end
