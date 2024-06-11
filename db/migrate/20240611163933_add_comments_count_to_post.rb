class AddCommentsCountToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_feeds_posts, :comments_count, :integer, null: false, default: 0, index: true
    Decidim::Feeds::Post.reset_column_information
    Decidim::Feeds::Post.find_each(&:update_comments_count)
  end
end
