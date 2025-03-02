class AddFollowableCounterCacheToFeeds < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_feeds_feeds, :follows_count, :integer, null: false, default: 0, index: true

    reversible do |dir|
      dir.up do
        Decidim::Feeds::Feed.reset_column_information
        Decidim::Feeds::Feed.unscoped.find_each do |record|
          record.class.reset_counters(record.id, :follows)
        end
      end
    end
  end
end
