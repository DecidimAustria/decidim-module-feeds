# frozen_string_literal: true

module Decidim
  class RoleAssignedToFeedEvent < Decidim::Events::SimpleEvent
    include Decidim::Events::AuthorEvent

    def i18n_role
      I18n.t(extra["role"], scope: "decidim.admin.models.assembly_user_role.roles", default: extra["role"])
    end

    def i18n_options
      {
        resource_path:,
        resource_title:,
        resource_url:,
        scope: event_name,
        participatory_space_title:,
        participatory_space_url:,
        role: i18n_role
      }
    end
  end
end
