module Decidim
  module Feeds
    class UserAnswer < Feeds::ApplicationRecord
      belongs_to :decidim_feeds_answer, class_name: 'Decidim::Feeds::Answer', foreign_key: "decidim_feeds_answer_id"
      belongs_to :decidim_user, class_name: 'Decidim::User', foreign_key: "decidim_user_id"

      # validate combination of user and answer
      validates :decidim_user_id, uniqueness: { scope: :decidim_feeds_answer_id }
    end
  end
end
