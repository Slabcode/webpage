class AuthorByPost < ApplicationRecord
  belongs_to :author
  belongs_to :post
end
