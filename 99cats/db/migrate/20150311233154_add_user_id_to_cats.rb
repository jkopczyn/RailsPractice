class AddUserIdToCats < ActiveRecord::Migration
  def change
    add_column :cats, :user_id, :string, null: false, default: 0
    add_index :cats, :user_id
  end
end
