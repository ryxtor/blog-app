class Post < ActiveRecord::Base
  belongs_to :user, class_name: 'User'
  has_many :comments, class_name: 'Comment'
  has_many :likes, class_name: 'Like'
end
