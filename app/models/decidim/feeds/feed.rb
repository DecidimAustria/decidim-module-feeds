# frozen_string_literal: true

module Decidim
  module Feeds
    class Feed < ApplicationRecord
      include Decidim::Participable
      include Decidim::ParticipatorySpaceResourceable
      include Decidim::TranslatableResource
      include Decidim::Loggable
      include Decidim::Traceable
      # include Decidim::Searchable
      # include Decidim::HasAttachments
      # include Decidim::HasAttachmentCollections
      # include Decidim::Publicable
      # include Decidim::ScopableParticipatorySpace
      # include Decidim::Followable
      # include Decidim::HasReference
      # include Decidim::HasPrivateUsers
      # include Decidim::HasUploadValidations
      # include Decidim::FilterableResource

      translatable_fields :title

      belongs_to :organization,
                foreign_key: "decidim_organization_id",
                class_name: "Decidim::Organization"

      has_many :components, as: :participatory_space, dependent: :destroy

      # has_one_attached :hero_image
      # validates_upload :hero_image, uploader: Decidim::HeroImageUploader

      # has_one_attached :banner_image
      # validates_upload :banner_image, uploader: Decidim::BannerImageUploader

      validates :slug, uniqueness: { scope: :organization }
      validates :slug, presence: true, format: { with: Decidim::Feeds::Feed.slug_format }

      # searchable_fields({
      #                     scope_id: :decidim_scope_id,
      #                     participatory_space: :itself,
      #                     A: :title,
      #                     B: :subtitle,
      #                     C: :short_description,
      #                     D: :description,
      #                     datetime: :published_at
      #                   },
      #                   index_on_create: ->(_feed) { false },
      #                   index_on_update: ->(feed) { feed.visible? })

      # Overwriting existing method Decidim::HasPrivateUsers.public_spaces
      # def self.public_spaces
      #   where(private_space: false).or(where(private_space: true).where(is_transparent: true)).published
      # end

      def self.log_presenter_class_for(_log)
        Decidim::Feeds::AdminLog::FeedPresenter
      end

      # def hashtag
      #   attributes["hashtag"].to_s.delete("#")
      # end

      def to_param
        slug
      end

      def translated_title
        Decidim::AssemblyPresenter.new(self).translated_title
      end

      # private

      # Allow ransacker to search for a key in a hstore column (`title`.`en`)
      # ransacker_i18n :title # requires filterable
    end
  end
end