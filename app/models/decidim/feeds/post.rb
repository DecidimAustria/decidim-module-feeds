module Decidim
  module Feeds
    # The data store for a Proposal in the Decidim::Proposals component.
    class Post < Feeds::ApplicationRecord
      include Decidim::Resourceable
      include Decidim::Authorable
      include Decidim::Reportable
      include Decidim::HasAttachments
      include Decidim::Comments::Commentable
      include Decidim::Searchable
      include Decidim::Endorsable
      include Decidim::TranslatableResource
      include Decidim::TranslatableAttributes
      include Decidim::Fingerprintable
      include Decidim::HasComponent
      # include Decidim::Loggable
      # include Decidim::DownloadYourData
      # include Decidim::Randomable
      # include Decidim::ScopableResource
      # include Decidim::HasReference
      # include Decidim::HasCategory
      # include Decidim::Followable
      # include Decidim::Traceable
      # include Decidim::NewsletterParticipant
      # include Decidim::FilterableResource

      # belongs_to :organization, class_name: "Decidim::Organization"

      component_manifest_name "feeds"

      translatable_fields :body

      fingerprint fields: [:body]

      validates :body, presence: true

      searchable_fields(
        {
          participatory_space: { component: :participatory_space },
          organization_id: :organization_id,
          A: :body,
          datetime: :created_at
        },
        index_on_create: true,
        index_on_update: true
      )

      def self.filter_category(category)
        return self if category.blank?

        where(category:)
      end

      # Posts don't have a title, but Commentable requires it, so let's extract the first words of each translation of the body
      def title
        truncated_body = {}
        body.each do |locale, translations|
          if locale == "machine_translations"
            truncated_body[locale] = {}
            translations.each do |key, value|
              truncated_body[locale][key] = value.first.truncate_words(4)
            end
          else
            truncated_body[locale] = translations.first.truncate_words(4)
          end
        end
        truncated_body
      end
    end
  end
end
