module Decidim
  module Feeds
    # This cell renders the Search (:s) feed card
    # for a given instance of a feed
    class FeedSCell < Decidim::CardSCell
      private

      def metadata_cell
        "decidim/feeds/feed_metadata_g"
      end
    end
  end
end