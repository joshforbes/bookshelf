class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.text :description
      t.integer :pages
      t.date :published_date

      t.timestamps

      t.index :isbn, unique: true
    end
  end
end