class RemoveTitleFromAnswer < ActiveRecord::Migration[6.1]
  def change
    remove_column :decidim_feeds_answers, :title, :string
  end
end
