class CreateAuthorByPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :author_by_posts do |t|
      t.references :author, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
    add_index :author_by_posts, [:author_id,:post_id], unique: true
  end
end
