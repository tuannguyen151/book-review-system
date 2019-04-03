class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.integer :activitable_id
      t.string :activitable_type

      t.timestamps
    end
    add_index :activities, :user_id
    add_index :activities, %i(activitable_id activitable_type)
  end
end
