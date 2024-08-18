# frozen_string_literal: true

module Decidim
  module FeedsSpace
    module Admin
      # A class used to find the admins for an feed or an organization feeds.
      class AdminUsers < Decidim::Query
        # Syntactic sugar to initialize the class and return the queried objects.
        #
        # feed - an feed that needs to find its feed admins
        def self.for(feed)
          new(feed).query
        end

        # Syntactic sugar to initialize the class and return the queried objects.
        #
        # organization - an organization that needs to find its feed admins
        def self.for_organization(organization)
          new(nil, organization).query
        end

        # Initializes the class.
        #
        # feed - an feed that needs to find its feed admins
        # organization - an organization that needs to find its feed admins
        def initialize(feed, organization = nil)
          @feed = feed
          @organization = feed&.organization || organization
        end

        # Finds organization admins and the users with role admin for the given feed.
        #
        # Returns an ActiveRecord::Relation.
        def query
          organization.admins.or(feeds_user_admins)
        end

        private

        attr_reader :feed, :organization

        def feeds_user_admins
          # Decidim::User.where(
          #   id: Decidim::FeedUserRole.where(feed: feeds, role: :admin)
          #                                .select(:decidim_user_id)
          # )
          Decidim::User.where(admin: true)
        end

        def feeds
          if feed
            [feed]
          else
            Decidim::Feed.where(organization:)
          end
        end
      end
    end
  end
end
