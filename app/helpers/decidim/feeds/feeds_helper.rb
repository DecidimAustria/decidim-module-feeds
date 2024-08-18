# frozen_string_literal: true

module Decidim
  module Feeds
    # Helpers related to the Feeds layout.
    module FeedsHelper
      include Decidim::ResourceHelper
      # include Decidim::AttachmentsHelper
      include Decidim::IconHelper
      include Decidim::SanitizeHelper
      include Decidim::ResourceReferenceHelper
      # include Decidim::FiltersHelper
      # include FilterFeedsHelper

      # Items to display in the navigation of an feed
      def feed_nav_items(participatory_space)
        components = participatory_space.components.published.or(Decidim::Component.where(id: try(:current_component)))

        [
          *(if participatory_space.members.not_ceased.any?
              [{
                name: t("feed_member_menu_item", scope: "layouts.decidim.feed_navigation"),
                url: decidim_feeds.feed_feed_members_path(participatory_space),
                active: is_active_link?(decidim_feeds.feed_feed_members_path(participatory_space), :inclusive)
              }]
            end
           )
        ] + components.map do |component|
          {
            name: decidim_escape_translated(component.name),
            url: main_component_path(component),
            active: is_active_link?(main_component_path(component), :inclusive)
          }
        end
      end
    end
  end
end
