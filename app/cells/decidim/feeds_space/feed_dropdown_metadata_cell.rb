# frozen_string_literal: true

module Decidim
  module FeedsSpace
    class FeedDropdownMetadataCell < Decidim::ParticipatorySpaceDropdownMetadataCell
      # include FeedsHelper
      include Decidim::ComponentPathHelper
      include ActiveLinkTo

      def decidim_feeds
        Decidim::FeedsSpace::Engine.routes.url_helpers
      end

      private

      def nav_items_method = :feed_nav_items
    end
  end
end
