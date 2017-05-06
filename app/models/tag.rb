class Tag < ApplicationRecord
  before_destroy :only_tag
  default_scope {order("tags.name ASC")}
  has_many :post_by_tags
  has_many :posts, through: :post_by_tags, dependent: :destroy
  validates_presence_of :name,:description
  validates :name,length: {minimum: 3}
  validates :description,length: {minimum: 10}

  private
  def only_tag
    self.posts.each do |p|
      if p.tags.count < 2
        raise 'Some posts has a this tag as unique'
      end
    end

  end
end
