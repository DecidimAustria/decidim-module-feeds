class AddBodyToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_feeds_posts, :body, :jsonb
  end
end
