class RemoveTitleFromQuestion < ActiveRecord::Migration[6.1]
  def change
    remove_column :decidim_feeds_questions, :title, :string
  end
end
  