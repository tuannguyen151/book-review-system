class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :parent_id
      t.integer :user_id
      t.integer :commentable_id
      t.string :commentable_type

      t.timestamps
    end
    add_index :comments, :parent_id
    add_index :comments, %i(commentable_id commentable_type)
  end
end
