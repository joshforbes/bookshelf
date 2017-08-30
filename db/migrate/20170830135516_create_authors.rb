class CreateAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :authors do |t|
      t.string :name

      t.timestamps

      t.index :name, unique: true
    end
  end
end
