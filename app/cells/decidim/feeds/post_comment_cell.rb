# frozen_string_literal: true

module Decidim
  module Feeds
    class PostCommentCell < Decidim::ViewModel
      include Cell::ViewModel::Partial
      include Decidim::Comments::CommentsHelper
      def show
        render :show
      end

      def post
        model
      end

      def post_commentable
        model.enable_comments?
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
