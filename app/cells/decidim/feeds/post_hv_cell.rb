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

      def post_commentable
        model.enable_comments?
      end
    end
  end
end