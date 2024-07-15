# frozen_string_literal: true

module Decidim
  module Feeds
    class MeetingCell < Decidim::ViewModel
      include PostCellsHelper
      include Decidim::Meetings::MeetingCellsHelper
      include Cell::ViewModel::Partial

      def show
        render :show
      end

      def meeting
        model
      end

      def meeting_author
        model.decidim_author_id
      end

      def meeting_title
        translated_attribute model.title
      end

      def meeting_description
        translated_attribute model.description
      end

      def meeting_address
        model.address
      end

      def comments_enabled
        model.comments_enabled?
      end

    end
  end
end
