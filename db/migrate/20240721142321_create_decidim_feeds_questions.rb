class CreateDecidimFeedsQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :decidim_feeds_questions do |t|
      t.belongs_to :decidim_feeds_post, null: false, foreign_key: true
      t.string :title
      t.integer :question_type

      t.timestamps
    end
  end
end
