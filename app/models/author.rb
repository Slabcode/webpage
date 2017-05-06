class Author < ApplicationRecord
  before_destroy :only_author
  default_scope {order("authors.name ASC").order("authors.lastname ASC")}
  has_many :author_by_posts, dependent: :destroy
  has_many :posts, through: :author_by_posts
  validates_presence_of :name,:lastname,:email
  validates :name,:lastname,length: {minimum: 3}
  validates_uniqueness_of :email, :case_sensitive => false

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
