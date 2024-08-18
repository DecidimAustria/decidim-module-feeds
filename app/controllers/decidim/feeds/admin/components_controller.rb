# frozen_string_literal: true

module Decidim
  module Feeds
    module Admin
      # Controller that allows managing the Feed Components in the
      # admin panel.
      #
      class ComponentsController < Decidim::Admin::ComponentsController
        include Concerns::FeedAdmin

        def index
          enforce_permission_to :read, :component
          # only allow feeds component
          @manifests = Decidim.component_manifests.select {|c| c.name == :feeds}
          @components = current_participatory_space.components
        end
      end
    end
  end
end
