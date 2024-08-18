# frozen_string_literal: true

module Decidim
  module FeedsSpace
    # This class infers the current feed we are scoped to by
    # looking at the request parameters and the organization in the request
    # environment, and injects it into the environment.
    class CurrentFeed
      # Public: Matches the request against a feed and injects it
      #         into the environment.
      #
      # request - The request that holds the feeds relevant
      #           information.
      #
      # Returns a true if the request matched, false otherwise
      def matches?(request)
        env = request.env

        @organization = env["decidim.current_organization"]
        return false unless @organization

        current_feed(env, request.params) ? true : false
      end

      private

      def current_feed(env, params)
        env["decidim.current_participatory_space"] ||=
          detect_current_feed(params)
      end

      def detect_current_feed(params)
        organization_feeds.where(slug: params["feed_slug"]).or(
          organization_feeds.where(id: params["feed_slug"])
        ).first!
      end

      def organization_feeds
        @organization_feeds ||= OrganizationFeeds.new(@organization).query
      end
    end
  end
end
