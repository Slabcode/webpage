class Post < ApplicationRecord
  default_scope {order("posts.title ASC")}
  scope :order_by_created_at, -> (ord) {order("posts.created_at #{ord}")}
  has_many :comments, dependent: :destroy
  has_many :post_by_tags, dependent: :destroy
  has_many :tags, through: :post_by_tags
  has_many :author_by_posts, dependent: :destroy
  has_many :authors, through: :author_by_posts
  validates_presence_of :title,:image
end
