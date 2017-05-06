class Comment < ApplicationRecord
  default_scope {order("comments.created_at DESC")}
  belongs_to :post
  validates_presence_of :message
  validates :message, length: {minimum: 15}
end
