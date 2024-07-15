# frozen_string_literal: true

module Decidim
  module Feeds
    class MeetingCell < Decidim::ViewModel
      include PostCellsHelper
      include Cell::ViewModel::Partial

      def show
        render :show
      end

      def meeting
        model
      end

      def meeting_title
        translated_attribute model.title
      end
    end
  end
end
