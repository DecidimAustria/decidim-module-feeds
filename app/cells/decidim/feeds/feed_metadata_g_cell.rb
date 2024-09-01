# frozen_string_literal: true

module Decidim
  module Feeds
    # This cell renders the feed metadata for g card
    class FeedMetadataGCell < Decidim::CardMetadataCell
      include Cell::ViewModel::Partial

      alias current_feed resource
      alias feed resource

      def initialize(*)
        super

        @items.prepend(*feed_items)
      end

      private

      def feed_items
        []
      end
    end
  end
end
