class DeleteDecidimFeedsFeeds < ActiveRecord::Migration[6.1]
  def up
    drop_table :decidim_feeds_feeds
  end
end
