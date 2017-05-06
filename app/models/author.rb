class Author < ApplicationRecord
  before_destroy :only_author
  default_scope {order("authors.name ASC").order("authors.lastname ASC")}
  has_many :author_by_posts, dependent: :destroy
  has_many :posts, through: :author_by_posts
  validates_presence_of :name,:lastname,:email
  validates :name,:lastname,length: {minimum: 3}
  validates_uniqueness_of :email, :case_sensitive => false

  def self.load_authors(**args)
    includes(:posts)
      .paginate(:page => args[:page] || 1,:per_page => args[:per_page] || 10)
  end

  def self.author_by_id(id)
    includes(:posts)
      .find_by_id(id)
  end

  def self.authors_by_ids(ids,**args)
    load_authors(args)
      .where(authors:{
        id: ids
        })
  end

  def self.autors_by_search(q,**args)
    load_authors(args)
      .where(["lower(name) LIKE :name or lower(lastname) LIKE :name",{name: "%#{q.downcase}%"}])
  end

  private
  def only_author
    ids = []
    self.posts.each do |p|
      if p.authors.count < 2
        ids << p.id
      end
    end
    Post.destroy_all(id: ids)
  end
end
