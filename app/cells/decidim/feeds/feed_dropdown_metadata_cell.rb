# frozen_string_literal: true

module Decidim
  module Feeds
    class FeedDropdownMetadataCell < Decidim::ParticipatorySpaceDropdownMetadataCell
      # include FeedsHelper
      include Decidim::ComponentPathHelper
      include ActiveLinkTo

      def decidim_feeds
        Decidim::Feeds::Engine.routes.url_helpers
      end

      private

      def nav_items_method = :assembly_nav_items
    end
  end
end
