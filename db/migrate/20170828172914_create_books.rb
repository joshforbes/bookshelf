class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.integer :isbn
      t.string :title
      t.string :subtitle
      t.text :description
      t.integer :pages
      t.date :published_date

      t.timestamps

      t.index :isbn, unique: true
    end
  end
end
