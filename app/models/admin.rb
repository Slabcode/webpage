class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :name,:lastname,:username
  validates :name,:lastname,length: {minimum: 3}
  validates_uniqueness_of :username, :case_sensitive => false

  def self.load_admins(**args)
    paginate(:page => args[:page],:per_page => args[:per_page])
  end

  def self.admin_by_id(id)
    find_by_id(id)
  end

  def self.admins_by_ids(ids,**args)
    load_admins(**args).where(admins:{
        id: ids
    })
  end

  def self.admins_by_search(q,**args)
    load_admins(**args)
      .where(["lower(:name) LIKE ? or lower(:name) LIKE ? or lower(:name) LIKE ?", {name: "%#{q.downcase}%"}])
  end

end
