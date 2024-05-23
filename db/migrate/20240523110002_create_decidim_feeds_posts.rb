class CreateDecidimFeedsPosts < ActiveRecord::Migration[5.0]
    def change
      create_table :decidim_feeds_posts do |t|
        t.text :body, null: false
        t.string :category, null: false
        t.boolean :enable_comments, default: true

        t.references :decidim_author, index: true
  
        t.timestamps
      end
    end
  end