class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :activity_id

      t.timestamps
    end
    add_index :likes, %i(user_id activity_id), unique: true
  end
end
