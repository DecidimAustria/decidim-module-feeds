# frozen_string_literal: true

module Decidim
  module Feeds
    # This cell renders the process card for an instance of a Feed
    # the default size is the Medium Card (:m)
    class FeedCell < Decidim::ViewModel
      def show
        cell card_size, model, options
      end

      private

      def card_size
        case @options[:size]
        when :s
          "decidim/feeds/feed_s"
        else
          "decidim/feeds/feed_g"
        end
      end
    end
  end
end
