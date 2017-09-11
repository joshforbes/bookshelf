class AddOwnerToBooks < ActiveRecord::Migration[5.1]
  def change
    add_reference :books, :owner, after: 'id', foreign_key: { to_table: :users }
  end
end
