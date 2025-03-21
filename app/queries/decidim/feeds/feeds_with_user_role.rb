# frozen_string_literal: true

module Decidim
  module Feeds
    # A class used to find the Feeds that the given user has
    # the specific role privilege.
    class FeedsWithUserRole < Decidim::Query
      # Syntactic sugar to initialize the class and return the queried objects.
      #
      # user - a User that needs to find which feeds can manage
      # role - (optional) a Symbol to specify the role privilege
      def self.for(user, role = :any)
        new(user, role).query
      end

      # Initializes the class.
      #
      # user - a User that needs to find which feeds can manage
      # role - (optional) a Symbol to specify the role privilege
      def initialize(user, role = :any)
        @user = user
        @role = role
      end

      # Finds the Feeds that the given user has role privileges.
      # If the special role ':any' is provided it returns all feeds where
      # the user has some kind of role privilege.
      #
      # Returns an ActiveRecord::Relation.
      def query
        # Admin users have all role privileges for all organization feeds
        return Feeds::OrganizationFeeds.new(user.organization).query if user.admin?

        Feed.where(id: feed_ids)
      end

      private

      attr_reader :user, :role

      def feed_ids
        user_roles = FeedUserRole.where(user:) if role == :any
        user_roles = FeedUserRole.where(user:, role:) if role != :any
        user_roles.pluck(:decidim_feed_id)
      end
    end
  end
end
