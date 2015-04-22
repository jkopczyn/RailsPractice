class FixCatsUserIds < ActiveRecord::Migration
  def change
    add_column :cats, :dummy_user_id, :integer, null: false, default: 0
    Cat.all.each do |cat|
      cat.update!(dummy_user_id: cat.user_id.to_i)
    end
    remove_column :cats, :user_id
    rename_column :cats, :dummy_user_id, :user_id
  end
end
