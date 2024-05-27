module Decidim
  module Feeds
    # The data store for a Proposal in the Decidim::Proposals component.
    class Post < Feeds::ApplicationRecord
      include Decidim::Authorable
      include Decidim::Reportable
      include Decidim::HasAttachments
      include Decidim::Comments::Commentable
      include Decidim::Searchable
      include Decidim::Endorsable
      include Decidim::TranslatableResource
      include Decidim::TranslatableAttributes
      include Decidim::Fingerprintable
      # include Decidim::Loggable
      # include Decidim::DownloadYourData
      # include Decidim::Resourceable
      # include Decidim::HasComponent
      # include Decidim::Randomable
      # include Decidim::ScopableResource
      # include Decidim::HasReference
      # include Decidim::HasCategory
      # include Decidim::Followable
      # include Decidim::Traceable
      # include Decidim::NewsletterParticipant
      # include Decidim::FilterableResource

      belongs_to :organization, class_name: "Decidim::Organization"

      translatable_fields :body

      fingerprint fields: [:body]

      validates :body, presence: true

      searchable_fields(
        {
          # participatory_space: { component: :participatory_space },
          organization_id: :organization_id,
          A: :body,
          datetime: :created_at
        },
        index_on_create: true,
        index_on_update: true
      )
    end
  end
end
