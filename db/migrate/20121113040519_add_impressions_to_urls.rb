class AddImpressionsToUrls < ActiveRecord::Migration
  def change
    add_column :urls, :impressions, :integer
  end
end
