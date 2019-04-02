class CreateMarkers < ActiveRecord::Migration[5.2]
  def change
    create_table :markers do |t|
      t.integer :status
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
    add_index :markers, :status
    add_index :markers, %i(user_id book_id)
  end
end
