# frozen_string_literal: true

module Decidim
  module Feeds
    module Admin
      # A form object used to create feed user roles from the admin dashboard.
      #
      class FeedUserRoleForm < Decidim::Admin::ParticipatorySpaceAdminUserForm
        mimic :feed_user_role

        def scope = "decidim.admin.models.feed_user_role.roles"
      end
    end
  end
end