class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.boolean :private, default: true, null: false
      t.text :content, null: false
      t.string :title, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end

    add_index :goals, :user_id
  end
end
