class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :display_name

      t.timestamps

      t.index :email, unique: true
      t.index :display_name, unique: true
    end
  end
end
