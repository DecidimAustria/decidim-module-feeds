# frozen_string_literal: true
class AddFeedUserRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :decidim_feeds_feed_user_roles do |t|
      t.integer :decidim_user_id
      t.integer :decidim_feed_id
      t.string :role
      t.timestamps
    end

    add_index :decidim_feeds_feed_user_roles,
              [:decidim_feed_id, :decidim_user_id, :role],
              unique: true,
              name: "index_unique_user_and_feed_role"
  end
end
