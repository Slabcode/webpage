class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :message, :null => false
      t.references :post, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
