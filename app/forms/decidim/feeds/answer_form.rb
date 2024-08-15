module Decidim
  module Feeds
    class AnswerForm < Decidim::Form
      include Decidim::TranslatableAttributes

      mimic :answer

      attribute :title, Decidim::Attributes::CleanString

      validates :title, presence: true
    end
  end
end