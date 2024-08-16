# frozen_string_literal: true

module Decidim
  module Feeds
    # This query class filters all feeds given an organization.
    class OrganizationFeeds < Decidim::Query
      def initialize(organization)
        @organization = organization
      end

      def query
        Decidim::Feeds::Feed.where(organization: @organization)
      end
    end
  end
end
