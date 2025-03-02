# frozen_string_literal: true
class AddFieldsToFeeds < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_feeds_feeds, :private_space, :boolean, default: false
    add_column :decidim_feeds_feeds, :is_transparent, :boolean, default: true
  end
end
