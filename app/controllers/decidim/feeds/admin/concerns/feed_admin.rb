# frozen_string_literal: true

require "active_support/concern"

module Decidim
  module Feeds
    module Admin
      module Concerns
        # This concern is meant to be included in all controllers that are scoped
        # into a feed's admin panel. It will override the layout so it shows
        # the sidebar, preload the feed, etc.
        module FeedAdmin
          extend ActiveSupport::Concern

          RegistersPermissions
            .register_permissions(::Decidim::Feeds::Admin::Concerns::FeedAdmin,
                                  Decidim::Feeds::Permissions,
                                  Decidim::Admin::Permissions)

          included do
            include Decidim::Admin::ParticipatorySpaceAdminContext
            helper_method :current_feed
            add_breadcrumb_item_from_menu :admin_feed_menu

            participatory_space_admin_layout

            def current_feed
              @current_feed ||= organization_feeds.find_by!(
                slug: params[:feed_slug] || params[:slug]
              )
            end

            alias_method :current_participatory_space, :current_feed

            def organization_feeds
              @organization_feeds ||= OrganizationFeeds.new(current_organization).query
            end

            def permissions_context
              super.merge(current_participatory_space:)
            end

            def permission_class_chain
              PermissionsRegistry.chain_for(FeedAdmin)
            end
          end
        end
      end
    end
  end
end
