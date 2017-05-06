class Tag < ApplicationRecord
  before_destroy :only_tag
  default_scope {order("tags.name ASC")}
  has_many :post_by_tags
  has_many :posts, through: :post_by_tags, dependent: :destroy
  validates_presence_of :name,:description
  validates :name,length: {minimum: 3}
  validates :description,length: {minimum: 10}

  def self.load_tags(**args)
    includes(:posts)
      .paginate(:page => args[:page] || 1 , :per_page => args[:per_page] || 10)
  end

  def self.tag_by_id(id)
    includes(:posts)
      .find_by_id(id)
  end

  def self.tags_by_ids(ids,**args)
    load_tags(**args)
      .where(tags: {
        id: ids
        })
  end

  def self.tags_by_search(q,**args)
    load_tags(**args)
      .where(["lower(name) LIKE :name",{name: "%#{q.downcase}%"}])
  end

  private
  def only_tag
    self.posts.each do |p|
      if p.tags.count < 2
        raise 'Some posts has a this tag as unique'
      end
    end

  end
end
