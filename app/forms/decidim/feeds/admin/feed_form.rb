# frozen_string_literal: true

module Decidim
  module Feeds
    module Admin
      # A form object used to create feeds from the admin
      # dashboard.
      #
      class FeedForm < Form
        include TranslatableAttributes

        mimic :feed

        translatable_attribute :title, String

        attribute :created_by, String
        attribute :slug, String
        
        # attribute :participatory_processes_ids, Array[Integer]
        # attribute :included_at, Decidim::Attributes::LocalizedDate

        # attribute :banner_image
        # attribute :hero_image
        # attribute :remove_banner_image, Boolean, default: false
        # attribute :remove_hero_image, Boolean, default: false

        validates :slug, presence: true, format: { with: Decidim::Feeds::Feed.slug_format }

        validate :slug_uniqueness
        # validate :same_type_organization, if: ->(form) { form.decidim_feeds_type_id }

        validates :title, translatable_presence: true

        # validates :banner_image, passthru: { to: Decidim::Feed }
        # validates :hero_image, passthru: { to: Decidim::Feed }

        # validates :weight, presence: true

        alias organization current_organization

        # def created_by_for_select
        #   CREATED_BY.map do |creator|
        #     [
        #       I18n.t("created_by.#{creator}", scope: "decidim.feeds"),
        #       creator
        #     ]
        #   end
        # end

        # def processes_for_select
        #   @processes_for_select ||= organization_participatory_processes
        #                                 &.map { |pp| [translated_attribute(pp.title), pp.id] }
        #                                 &.sort_by { |arr| arr[0] }
        # end

        private

        # def organization_participatory_processes
        #   Decidim.find_participatory_space_manifest(:participatory_processes)
        #          .participatory_spaces.call(current_organization)
        # end

        def organization_feeds
          OrganizationFeeds.new(current_organization).query
        end

        def slug_uniqueness
          return unless organization_feeds
                        .where(slug:)
                        .where.not(id: context[:feed_id])
                        .any?

          errors.add(:slug, :taken)
        end

        # def same_type_organization
        #   return unless feed_type
        #   return if feed_type.organization == current_organization

        #   errors.add(:feed_type, :invalid)
        # end
      end
    end
  end
end
