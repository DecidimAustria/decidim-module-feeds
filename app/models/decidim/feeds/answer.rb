module Decidim
  module Feeds
    class Answer < Feeds::ApplicationRecord
      include Decidim::TranslatableResource
      include Decidim::TranslatableAttributes

      belongs_to :question, class_name: "Decidim::Feeds::Question", foreign_key: "decidim_feeds_question_id"
      has_many :user_answers, class_name: "Decidim::Feeds::UserAnswer", dependent: :destroy, foreign_key: "decidim_feeds_answer_id"

      translatable_fields :title
    end
  end
end
