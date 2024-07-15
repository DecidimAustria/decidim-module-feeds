# frozen_string_literal: true

module Decidim
  module Feeds
    class PostCommentCell < Decidim::ViewModel
      include Cell::ViewModel::Partial
      include Decidim::ResourceHelper
      include Decidim::Comments::CommentsHelper
      def show
        render :show
      end

      def post
        model
      end

      def model_type
        if model.is_a?(Decidim::Feeds::Post)
          "Post"
        elsif model.is_a?(Decidim::Meetings::Meeting)
          "Meeting"
        else
          "Post"
        end
      end

      def post_commentable
        if model.respond_to?(:enable_comments?)
          model.enable_comments?
        elsif model.respond_to?(:comments_enabled?)
          model.comments_enabled?
        else
          false # Default to false if neither method exists
        end
      end

      def machine_translations_toggled?
        RequestStore.store[:toggle_machine_translations]
      end
      
      def comments_count
        model.comments_count
      end

      

    end
  end
end
