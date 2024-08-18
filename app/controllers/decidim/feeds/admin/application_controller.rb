# frozen_string_literal: true

module Decidim
  module Feeds
    module Admin
      # The main admin application controller for feeds
      class ApplicationController < Decidim::Admin::ApplicationController
        register_permissions(::Decidim::Feeds::Admin::ApplicationController,
                             Decidim::Feeds::Permissions,
                             Decidim::Admin::Permissions)

        private

        def permissions_context
          super.merge(
            current_participatory_space: try(:current_participatory_space)
          )
        end

        def permission_class_chain
          ::Decidim.permissions_registry.chain_for(::Decidim::Feeds::Admin::ApplicationController)
        end
      end
    end
  end
end
