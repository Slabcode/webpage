class CreatePostByTags < ActiveRecord::Migration[5.0]
  def change
    create_table :post_by_tags do |t|
      t.references :tag, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
    add_index :post_by_tags, [:tag_id,:post_id], unique: true
  end

end
