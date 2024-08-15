module Decidim
  module Feeds
    class QuestionForm < Decidim::Form
      include Decidim::TranslatableAttributes

      mimic :question

      attribute :title, Decidim::Attributes::CleanString
      attribute :answers, Array[AnswerForm]
      attribute :deleted, Boolean, default: false
      attribute :question_type, String

      validates :title, presence: true

      def map_model(model)
        self.title = translated_attribute(model.title)
      end
    end
  end
end
