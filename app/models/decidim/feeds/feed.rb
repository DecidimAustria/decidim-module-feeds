# frozen_string_literal: true

module Decidim
  module Feeds
    class Feed < ApplicationRecord
      include Decidim::Participable
      include Decidim::ParticipatorySpaceResourceable
      include Decidim::TranslatableResource
      include Decidim::Loggable
      include Decidim::Traceable
      include Decidim::Searchable
      include Decidim::HasAttachments
      # include Decidim::HasAttachmentCollections
      # include Decidim::Publicable
      include Decidim::ScopableParticipatorySpace
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
      has_many :categories,
             foreign_key: "decidim_participatory_space_id",
             foreign_type: "decidim_participatory_space_type",
             dependent: :destroy,
             as: :participatory_space

      # has_one_attached :hero_image
      # validates_upload :hero_image, uploader: Decidim::HeroImageUploader

      # has_one_attached :banner_image
      # validates_upload :banner_image, uploader: Decidim::BannerImageUploader

      validates :slug, uniqueness: { scope: :organization }
      validates :slug, presence: true, format: { with: Decidim::Feeds::Feed.slug_format }

      searchable_fields(
        {
          # scope_id: :decidim_scope_id,
          participatory_space: :itself,
          A: :title,
          # B: :subtitle,
          # C: :short_description,
          # D: :description,
          datetime: :created_at
        },
        index_on_create: true,
        index_on_update: true
      )

      # Overwriting existing method Decidim::HasPrivateUsers.public_spaces
      # def self.public_spaces
      #   where(private_space: false).or(where(private_space: true).where(is_transparent: true)).published
      # end

      def self.log_presenter_class_for(_log)
        Decidim::Feeds::AdminLog::FeedPresenter
      end

      # This is required by participable, but Feed is not publicable
      def self.published
        all
      end

      # def hashtag
      #   attributes["hashtag"].to_s.delete("#")
      # end

      def to_param
        slug
      end

      def translated_title
        Decidim::FeedPresenter.new(self).translated_title
      end

      def scopes_enabled?
        false
      end

      def scope
        nil
      end

      def followers
        Decidim::User.none
      end

      def private_space?
        false
      end

      def has_subscopes?
        false
      end

      def published?
        true
      end

      # private

      # Allow ransacker to search for a key in a hstore column (`title`.`en`)
      # ransacker_i18n :title # requires filterable
    end
  end
end