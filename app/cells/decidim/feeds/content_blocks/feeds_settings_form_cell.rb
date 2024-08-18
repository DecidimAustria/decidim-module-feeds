# frozen_string_literal: true

module Decidim
  module Feeds
    module ContentBlocks
      class FeedsSettingsFormCell < Decidim::ViewModel
        # Found in HighlightedElementsForComponentSettingsFormCell
        #include Decidim::ContentBlocks::HasRelatedComponents
        alias form model

        def available_feeds_options
          available_feeds.map do |component|
            [translated_attribute(component.name), component.id]
          end
        end

        def available_feeds
          @available_feeds ||= Decidim::Component.where(manifest_name: "posts").where(participatory_space_id: current_organization.participatory_spaces.pluck(:id))
        end
      end
    end
  end
end
