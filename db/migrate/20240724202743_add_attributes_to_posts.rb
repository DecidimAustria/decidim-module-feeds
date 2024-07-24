class AddAttributesToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_feeds_posts, :highlighted, :boolean, default: false
    add_column :decidim_feeds_posts, :fixed, :boolean, default: false
    add_column :decidim_feeds_posts, :status, :integer, default: 0
  end
end
