class AddOrganizationToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_feeds_posts, :organization_id, :integer
  end
end
