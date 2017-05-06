class CreateAuthors < ActiveRecord::Migration[5.0]
  def change
    create_table :authors do |t|
      t.string :name, :null => false
      t.string :lastname, :null => false
      t.string :email, :null => false
      t.string :links, array: true, default: []

      t.timestamps
    end
  end
end
