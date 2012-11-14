class AddUserIdToUrls < ActiveRecord::Migration
  def up
    change_table :urls do |t|
      t.references :user
    end
  end

  def down
    remove_column :urls, :user_id
  end
end
