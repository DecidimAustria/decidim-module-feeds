# frozen_string_literal: true

class CreateDecidimFeedsSpaceFeeds < ActiveRecord::Migration[6.1]
  def change
    create_table :decidim_feeds_space_feeds do |t|
      t.string :slug, null: false

      t.integer :decidim_organization_id,
                foreign_key: true,
                index: { name: "index_decidim_feeds_feeds_on_decidim_organization_id" }

      t.string :created_by
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.jsonb :title, null: false
      
      t.index [:decidim_organization_id, :slug],
              name: "index_unique_feed_slug_and_organization",
              unique: true
    end
  end
end
