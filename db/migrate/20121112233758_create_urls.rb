class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :orig_url
      t.timestamps
    end
  end
end
