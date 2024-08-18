# frozen_string_literal: true

module Decidim
  module FeedsSpace
    # This query class filters all feeds given an organization.
    class OrganizationFeeds < Decidim::Query
      def initialize(organization)
        @organization = organization
      end

      def query
        Decidim::FeedsSpace::Feed.where(organization: @organization)
      end
    end
  end
end
