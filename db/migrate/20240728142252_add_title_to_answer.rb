class AddTitleToAnswer < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_feeds_answers, :title, :jsonb
  end
end
