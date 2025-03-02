# frozen_string_literal: true

module Decidim
  module Feeds
    module Admin
      # Controller that allows managing feed user roles.
      #
      class FeedUserRolesController < Decidim::Admin::ParticipatorySpace::UserRoleController
        include Concerns::FeedAdmin

        def authorization_scope = :feed_user_role

        def resource_form = form(FeedUserRoleForm)

        def space_index_path = feed_user_roles_path(current_participatory_space)

        def i18n_scope = "decidim.admin.feed_user_roles"

        def role_class = Decidim::Feeds::FeedUserRole

        def event = "decidim.events.feed.role_assigned"

        def event_class = Decidim::RoleAssignedToFeedEvent
      end
    end
  end
end
