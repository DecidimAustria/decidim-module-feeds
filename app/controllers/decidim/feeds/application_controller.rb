# frozen_string_literal: true

module Decidim
  module Feeds
    # The main admin application controller for feeds
    class ApplicationController < Decidim::ApplicationController
      helper Decidim::ApplicationHelper
      helper Decidim::Feeds::FeedsHelper
      include NeedsPermission

      register_permissions(Decidim::Feeds::ApplicationController,
                           ::Decidim::Feeds::Permissions,
                           ::Decidim::Admin::Permissions,
                           ::Decidim::Permissions)

      private

      def user_has_no_permission_path
        decidim.new_user_session_path
      end

      def permissions_context
        super.merge(
          current_participatory_space: try(:current_participatory_space)
        )
      end

      def permission_class_chain
        ::Decidim.permissions_registry.chain_for(::Decidim::Feeds::ApplicationController)
      end

      def permission_scope
        :public
      end
    end
  end
end
