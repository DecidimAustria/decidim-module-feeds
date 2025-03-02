# frozen_string_literal: true

module Decidim
  module Feeds
    # A form object used to create feeds from the admin
    # dashboard.
    #
    class FeedForm < Form
      include TranslatableAttributes
      include AttachmentAttributes

      mimic :feed

      translatable_attribute :title, String

      attribute :created_by, String
      attribute :attachment, AttachmentForm
      attribute :private_space, Boolean
      attribute :is_transparent, Boolean
      
      # attribute :participatory_processes_ids, Array[Integer]
      # attribute :included_at, Decidim::Attributes::LocalizedDate

      # attribute :banner_image
      # attribute :hero_image
      # attribute :remove_banner_image, Boolean, default: false
      # attribute :remove_hero_image, Boolean, default: false

      # validate :same_type_organization, if: ->(form) { form.decidim_feeds_type_id }

      attachments_attribute :documents

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

      def map_model(model)
        self.title = model.title # translated_attribute(model.title)
        # self.slug = model.slug
        self.documents = model.attachments
      end

      def has_attachments?
        feed.has_attachments? && errors[:documents].empty? && documents.present?
      end

      def has_error_in_attachments?
        errors[:documents].present?
      end

      private

      # def organization_participatory_processes
      #   Decidim.find_participatory_space_manifest(:participatory_processes)
      #          .participatory_spaces.call(current_organization)
      # end

      def organization_feeds
        OrganizationFeeds.new(current_organization).query
      end

      # def same_type_organization
      #   return unless feed_type
      #   return if feed_type.organization == current_organization

      #   errors.add(:feed_type, :invalid)
      # end
    end
  end
end
