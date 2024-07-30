class AddTotAnswersToDecidimFeedsAnswers < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_feeds_answers, :tot_answers, :integer
  end
end
