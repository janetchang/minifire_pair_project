class AddDefaultToUrls < ActiveRecord::Migration
  def change
    change_column :urls, :impressions, :integer, :default => 0
  end
end
