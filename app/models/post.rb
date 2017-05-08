class Post < ApplicationRecord
  mount_uploader :image, AvatarUploader
  default_scope {order("posts.title ASC")}
  scope :order_by_created_at, -> (ord) {order("posts.created_at #{ord}")}
  has_many :comments, dependent: :destroy
  has_many :post_by_tags, dependent: :destroy
  has_many :tags, through: :post_by_tags
  has_many :author_by_posts, dependent: :destroy
  has_many :authors, through: :author_by_posts
  validates_presence_of :title,:image

  def self.load_posts(**args)
    includes(:comments,:tags,:authors)
      .paginate(:page => args[:page] || 1, :per_page => args[:per_page] || 10)
  end

  def self.post_by_id(id)
    includes(:comments,:tags,:authors)
      .find_by_id(id)
  end

  def self.posts_by_ids(ids,**args)
    load_posts(args)
      .where(posts: {
        id: ids
        })
  end

  def self.posts_by_search(q,**args)
    load_posts(args)
      .where(["lower(title) LIKE :title",{title: "%#{q.downcase}%"}])
  end

  def self.posts_by_tags(tags,**args)
    joins(:tags).select("posts.*")
      .where(tags: {
          id: tags
      }).group("posts.id")
  end

  def self.posts_by_authors(authors,**args)
    joins(:authors).select("posts.*")
      .where(authors: {
          id: tags
      }).group("posts.id")
  end

end
