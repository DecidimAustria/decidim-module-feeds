# frozen_string_literal: true

module Decidim
  module Feeds
    module PostCellsHelper
      include Decidim::Feeds::ApplicationHelper
      include Decidim::Feeds::Engine.routes.url_helpers
      include Decidim::LayoutHelper
      include Decidim::ApplicationHelper
      include Decidim::TranslationsHelper
      include Decidim::ResourceReferenceHelper
      include Decidim::TranslatableAttributes
      include Decidim::CardHelper

      delegate :body, :category, to: :model

      def current_settings
        model.component.current_settings
      end

      def component_settings
        model.component.settings
      end

      def current_component
        model.component
      end

      def participatory_space
        @participatory_space ||= current_component.participatory_space
      end

    end
  end
end
