class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :rate
      t.text :content
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
    add_index :reviews, %i(user_id book_id)
  end
end
