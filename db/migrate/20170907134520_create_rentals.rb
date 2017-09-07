class CreateRentals < ActiveRecord::Migration[5.1]
  def change
    create_table :rentals do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.date :rented_at
      t.date :returned_at

      t.timestamps
    end
  end
end
