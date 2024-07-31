# frozen_string_literal: true

module Decidim
  module Feeds
    # Custom helpers used in posts views
    module PostsHelper
      include Decidim::ApplicationHelper
      include Decidim::TranslationsHelper
      include Decidim::ResourceHelper
      include Decidim::Meetings::ApplicationHelper

      def calendar_months
        [Date.current, Date.current.next_month]
      end

      def collection
        @collection ||= meetings.limit(limit)
      end

      def meetings
        @meetings ||= show_upcoming_meetings? ? upcoming_meetings : past_meetings
      end

      def limit
        3
      end

      def participatory_space
        @participatory_space ||= current_component.participatory_space
      end

    end
  end
end