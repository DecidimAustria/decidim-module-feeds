class RemoveBodyFromPost < ActiveRecord::Migration[6.1]
  def change
    remove_column :decidim_feeds_posts, :body, :string
  end
end
