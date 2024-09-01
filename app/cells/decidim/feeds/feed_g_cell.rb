# frozen_string_literal: true

module Decidim
  module Feeds
    # This cell renders the Grid (:g) feed card
    # for a given instance of a feed
    class FeedGCell < Decidim::CardGCell
      private

      def resource_path
        Decidim::Feeds::Engine.routes.url_helpers.feed_path(model)
      end

      def has_image?
        # image.present?
        false
      end

      def image
        # @image ||= model.attachments.find(&:image?)
        nil
      end

      def resource_image_path
        image.url if has_image?
      end

      def metadata_cell
        "decidim/feeds/feed_metadata_g"
      end
    end
  end
end
