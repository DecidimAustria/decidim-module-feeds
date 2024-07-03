# frozen_string_literal: true

module Decidim
  module Feeds
    class PostHvCell < Decidim::ViewModel
      include Cell::ViewModel::Partial
      def show
        render :show
      end

      def post
        model
      end

      def post_body
        translated_attribute model.body
      end

      def post_category
        model.category
      end

      # post status / for HV post
      # nil default
      # 1 bearbeitung
      # 2 erledigt

      def post_status
        nil
      end

      def status_class
        case post_status
          when 1
            'warning'
          when 2
            'success'
          else
            ''
          end
      end

      def post_highlighted
        false
      end

      def post_commentable
        model.enable_comments?
      end
    end
  end
end
