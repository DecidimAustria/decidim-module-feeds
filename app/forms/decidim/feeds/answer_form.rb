module Decidim
  module Feeds
    # A form object to be used when public users want to create a proposal.
    class AnswerForm < Decidim::Form
      include Decidim::TranslatableAttributes

      mimic :answer

      attribute :title, Decidim::Attributes::CleanString

      validates :title, presence: true
    end
  end
end