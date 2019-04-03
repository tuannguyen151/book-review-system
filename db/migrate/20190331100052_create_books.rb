class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :cover_image
      t.text :description
      t.datetime :publish_date
      t.integer :number_pages
      t.integer :price
      t.string :author
      t.integer :category_id

      t.timestamps
    end
    add_index :books, :title, unique: true
    add_index :books, :publish_date
    add_index :books, :price
    add_index :books, :author
    add_index :books, :category_id
  end
end
