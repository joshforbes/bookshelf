class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.text :description
      t.integer :pages
      t.integer :published_year
      t.string :cover_image_url
      t.boolean :active

      t.timestamps

      t.index :isbn
    end
  end
end
