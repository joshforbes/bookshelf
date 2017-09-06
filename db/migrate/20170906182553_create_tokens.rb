class CreateTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :tokens do |t|
      t.references :user, foreign_key: true
      t.string :body
      t.datetime :last_used_at, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps

      t.index :body, unique: true
    end
  end
end
