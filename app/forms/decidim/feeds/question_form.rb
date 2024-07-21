module Decidim
  module Feeds
    # A form object to be used when public users want to create a proposal.
    class QuestionForm < Decidim::Form
      include Decidim::TranslatableAttributes

      mimic :question

      attribute :title, Decidim::Attributes::CleanString
      attribute :answer, AnswerForm

      validates :title, presence: true
    end
  end
end