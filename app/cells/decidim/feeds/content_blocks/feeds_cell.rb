# frozen_string_literal: true

module Decidim
  module Feeds
    module ContentBlocks
      class FeedsCell < Decidim::ViewModel
        def block_id
          "feed-block-#{model.manifest_name.parameterize.gsub("_", "-")}"
        end

        def html_content
          translated_attribute(model.settings.html_content).html_safe
        end
      end
    end
  end
end