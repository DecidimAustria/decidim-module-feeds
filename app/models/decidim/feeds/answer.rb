module Decidim
  module Feeds
    # The data store for a Proposal in the Decidim::Proposals component.
    class Answer < Feeds::ApplicationRecord
      include Decidim::TranslatableResource
      include Decidim::TranslatableAttributes

      belongs_to :question, class_name: "Decidim::Feeds::Question"

      translatable_fields :title
    end
  end
end
